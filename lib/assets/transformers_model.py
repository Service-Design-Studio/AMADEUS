from flask import Flask, jsonify, request
app = Flask(__name__)

from transformers import pipeline
classifier = pipeline("zero-shot-classification", model="facebook/bart-large-mnli")
summarizer = pipeline("summarization", model="facebook/bart-large-cnn")

@app.route('/', methods=['GET'])
def test():
    return jsonify({'message': 'It works!'})

@app.route('/categoriser', methods=['POST'])
def get_category():
    upload_text = request.json["inputs"]
    categories = request.json["parameters"]["candidate_labels"]
    if not categories:
        return jsonify({"data": {"category": "No Category"}})
    results = classifier(upload_text, candidate_labels=categories)
    top_category = results["labels"][0]
    return jsonify({"data": {"category": top_category}})

@app.route('/summariser', methods=['POST'])
def get_summary():
    upload_text = request.json["inputs"]
    summary = summarizer(upload_text, max_length=150, min_length=50, do_sample=False, truncation=True)[0]["summary_text"]
    return jsonify({"data": {"summary": summary}})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)
