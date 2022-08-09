from flask import Flask, jsonify, request
app = Flask(__name__)

from transformers import pipeline
classifier = pipeline("zero-shot-classification", model="facebook/bart-large-mnli")
summarizer = pipeline("summarization", model="facebook/bart-large-cnn")

from datetime import datetime

@app.route('/', methods=['GET'])
def test():
    return jsonify({'message': 'It works!'})

@app.route('/categoriser', methods=['POST'])
def get_category():
    now = datetime.now()
    print("\nTimestamp: " + now.strftime("%d/%m/%Y %H:%M:%S"))
    print("Parsing Category")
    upload_text = request.json["inputs"]
    print(upload_text[1:10])
    categories = request.json["parameters"]["candidate_labels"]
    if not categories:
        return jsonify({"data": {"category": "No Category"}})
    results = classifier(upload_text, candidate_labels=categories[-10:])
    top_category = results["labels"][0]
    print("Results: " + top_category)
    return jsonify({"data": {"category": top_category}})

@app.route('/summariser', methods=['POST'])
def get_summary():
    now = datetime.now()
    print("\nTimestamp: " + now.strftime("%d/%m/%Y %H:%M:%S"))
    print("Parsing Summary")
    upload_text = request.json["inputs"]
    print(upload_text[1:10])
    summary = summarizer(upload_text, max_length=100, min_length=50, do_sample=False, truncation=True)[0]["summary_text"]
    print("Result: " + summary.split(".")[0])
    return jsonify({"data": {"summary": summary}})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)
