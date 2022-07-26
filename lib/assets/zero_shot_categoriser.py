from flask import Flask, jsonify, request
app = Flask(__name__)

from transformers import pipeline
classifier = pipeline("zero-shot-classification", model="facebook/bart-large-mnli")

@app.route('/', methods=['GET'])
def test():
    return jsonify({'message': 'It works!'})

@app.route('/zero_shot', methods=['POST'])
def getCategory():
    upload_text = request.json["inputs"]
    categories = request.json["parameters"]["candidate_labels"]
    if not categories:
        return jsonify({"data": {"category": "No Category"}})
    results = classifier(upload_text, candidate_labels=categories)
    top_category = results["labels"][0]
    return jsonify({"data": {"category": top_category}})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)
