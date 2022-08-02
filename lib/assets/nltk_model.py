# All credits to Timothy W. https://github.com/weetimo
import random
import time

print("Finish setup")


def categoriser():
    categories = ['Tank', 'Artillery', 'UAV', 'Fighter Aircraft', 'Helicopter', 'Missile', 'MANPAD', 'Infrastructure']
    return random.choice(categories)


def tagger():
    tags_dict = { "a": 1, "b": 2, "c": 3, "d": 4, "e": 5 }
    return tags_dict

def summariser():
    return "This is a summary"


def nltk_model(request):
    request_json = request.get_json()
    request_args = request.args
    response = {}

    if request_json and 'upload_text' in request_json:
        upload_text = request_json['upload_text']
        # Run model
        tags_dict = tagger()
        summary = summariser()
        category = categoriser()
        response = {"summary": summary, "tags": tags_dict, "category": category}
    return response
