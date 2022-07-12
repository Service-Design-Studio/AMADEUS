# All credits to Timothy W. https://github.com/weetimo

import nltk
nltk.download('averaged_perceptron_tagger')
nltk.download('stopwords')
nltk.download('punkt')
nltk.download('wordnet')
nltk.download('omw-1.4')

from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize, sent_tokenize
from nltk.stem import WordNetLemmatizer
from sklearn.feature_extraction.text import TfidfVectorizer
from nltk.corpus import wordnet

def categoriser(upload_text, replace_dict, all_stopwords, num_topic):
        for old, new in replace_dict.items():
            upload_text = upload_text.replace(old, new)

        # Lemmatize input
        lemmatizer = WordNetLemmatizer()
        lemmatized_words = []
        words = word_tokenize(upload_text)
        for word in words:
            lemmatized_words.append(lemmatizer.lemmatize(word))
        upload_text = ' '.join(lemmatized_words)

        # Perform pos tagging
        pos_tagged = nltk.pos_tag(word_tokenize(upload_text.lower()))

        def pos_tagger(nltk_tag):
          # Identify nouns only
          if nltk_tag.startswith('N'):
            return wordnet.NOUN
          else:
            return None

        # Mapping the pos_tagger function to the pos_tagged list.
        # The pos_tagger function returns the wordnet.NOUN if the nltk_tag starts with 'N', otherwise it returns None.
        wordnet_tagged = list(map(lambda x: (x[0], pos_tagger(x[1])), pos_tagged))

        # Create array with only nouns
        noun_list = []
        for i in range(len(wordnet_tagged)):
          if wordnet_tagged[i][1] == wordnet.NOUN:
            noun_list.append(wordnet_tagged[i][0])

        # Sort noun_list by frequency
        noun_freq = nltk.FreqDist(noun_list)
        sorted_noun_freq = sorted(noun_freq.items(), key=lambda x: x[1], reverse=True)

        # Filter
        topics_dict = dict()
        count = 0
        for (noun, freq) in sorted_noun_freq:
            if count > int(num_topic):
                break
            if noun.isalpha() and noun not in all_stopwords and len(noun) > 2:
                if freq > 1:
                    topics_dict[noun] = freq
                    count += 1
        topics_dict["count"] = num_topic

        return topics_dict

def summariser(upload_text, all_stopwords, summary_threshold):
    words = word_tokenize(upload_text)

    # Count frequency
    freq_table = dict()
    for word in words:
        word = word.lower()
        if word in all_stopwords:
            continue
        if word in freq_table:
            freq_table[word] += 1
        else:
            freq_table[word] = 1

    # Label frequency
    sentence_value_dict = dict()
    sentences = sent_tokenize(upload_text)
    for sentence in sentences:
        for word, freq in freq_table.items():
            if word in sentence.lower():
                if sentence in sentence_value_dict:
                    sentence_value_dict[sentence] += freq
                else:
                    sentence_value_dict[sentence] = freq

    # Find total score and average
    scores = 0
    for sentence in sentence_value_dict:
        scores += sentence_value_dict[sentence]
    average = int(scores / len(sentence_value_dict))

    # Storing sentences into our summary.
    summary = sentences[0]
    for sentence in sentences[1:]:
        if (sentence in sentence_value_dict) and (sentence_value_dict[sentence] > (float(summary_threshold) * average)):
            summary += " " + sentence

    return summary


def nltk_model(request):
    request_json = request.get_json()
    request_args = request.args
    response = {}

    if request_json and 'upload' in request_json:
        # Extract params
        upload = request_json['upload']

        upload_text = upload['upload_text']
        replace_dict = upload['replace_dict']
        num_topic = upload['num_topic']
        summary_threshold = upload['summary_threshold']

        custom_stopwords = ["said", 'month', 'months', 'year', 'years', 'date', 'dates', 'official', 'bbc',
            'count', 'news', 'people','use', 'dji']
        original_stopwords = set(stopwords.words("english"))
        all_stopwords = original_stopwords.union(custom_stopwords)

        # Run model
        topics_dict = categoriser(upload_text, replace_dict, all_stopwords, num_topic)
        summary = summariser(upload_text, all_stopwords, summary_threshold)
        response = { "topics": topics_dict, "summary": summary }

    return response