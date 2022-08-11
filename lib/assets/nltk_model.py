# All credits to Timothy W. https://github.com/weetimo
import random
# import nltk
#
# nltk.download('wordnet')
# nltk.download('stopwords')
#
# from nltk.corpus import stopwords, wordnet
# from nltk.tokenize import word_tokenize
# from nltk.stem import WordNetLemmatizer

print("Finish setup")

def tagger(upload_text):
    tags_dict = {}
    ENTITY = ["PERSON", "LOCATION", "ORGANIZATION", "EVENT", "WORK_OF_ART", "CONSUMER_GOOD"]
    for i in range(3):
        # Entity Tag
        name = random.choice(upload_text.split())
        entity_type = random.choice(ENTITY)
        tags_dict[name] = entity_type
        # Other Tag
        name = random.choice(upload_text.split())
        tags_dict[name] = "OTHER"
    return tags_dict

def categoriser():
    categories = ['Tank', 'Artillery', 'UAV', 'Fighter Aircraft', 'Helicopter', 'Missile', 'MANPAD', 'Infrastructure']
    return random.choice(categories)

def summariser():
    return "This is a valid summary with more than 10 words and less than 100 words"

def legacy_tagger(upload_text, replace_dict, all_stopwords, num_tag):
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
    tags_dict = dict()
    count = 0
    for (noun, freq) in sorted_noun_freq:
        if count >= int(num_tag):
            break
        if noun.isalpha() and noun not in all_stopwords and len(noun) > 2:
            if freq > 1:
                tags_dict[noun] = freq
                count += 1

    return tags_dict

def legacy_summariser(upload_text, all_stopwords, summary_threshold):
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
    summary = []
    for sentence in sentences:
        if (sentence in sentence_value_dict) and (sentence_value_dict[sentence] > (float(summary_threshold) * average)):
            summary.append(sentence)
    summary = " ".join(summary[2:-1])
    return summary

def get_custom_stopwords():
    return [
        "time", "year", "people", "way", "day", "man", "thing", "woman", "life", "child", "world", "school", "state",
        "family", "student", "group", "country", "problem", "hand", "part", "place", "case", "week", "company",
        "system", "program", "question", "work", "government", "number", "night", "point", "home", "water",
        "room", "mother", "area", "money", "story", "fact", "month", "lot", "right", "study", "book", "eye", "job",
        "word", "business", "issue", "side", "kind", "head", "house", "service", "friend", "father", "power", "hour",
        "game", "line", "end", "member", "law", "car", "city", "community", "name", "president", "team", "minute",
        "idea", "kid", "body", "information", "back", "parent", "face", "others", "level", "office", "door", "health",
        "person", "art", "war", "history", "party", "result", "change", "morning", "reason", "research",
        "girl", "guy", "moment", "air", "teacher", "force", "education", "bbc", "news", "cna", "cnn", "thousands",
    ]

def nltk_model(request):
    request_json = request.get_json()
    request_args = request.args
    response = {}

    if request_json and 'upload' in request_json:
        # Extract params
        upload = request_json['upload']

        # START of legacy code
        upload_text = upload['upload_text']
        # replace_dict = upload['replace_dict']
        # num_tag = upload['num_tag']
        # summary_threshold = upload['summary_threshold']#
        # custom_stopwords = get_custom_stopwords()
        # original_stopwords = set(stopwords.words("english"))
        # all_stopwords = original_stopwords.union(custom_stopwords)
        # tags_dict = legacy_tagger(upload_text, replace_dict, all_stopwords, num_tag)
        # summary = legacy_summariser(upload_text, all_stopwords, summary_threshold)
        # END of legay code

        tags_dict = tagger(upload_text)
        category = categoriser()
        summary = summariser()
        response = {"summary": summary, "tags": tags_dict, "category": category}
    return response
