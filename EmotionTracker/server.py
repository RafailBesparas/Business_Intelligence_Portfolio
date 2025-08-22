"""Flask server for emotion detection."""

from flask import Flask, render_template, request, jsonify
from EmotionDetection import emotion_detector

# initiate the flask app
app = Flask(__name__)

# Home route to fetch the index html
@app.route('/')
def index():
    """Renders the index.html template."""
    return render_template('index.html')

@app.route('/emotionDetector', methods=['POST'])
def emotion_detection():
    """Handles emotion detection requests."""
    # request the text from the form
    text_to_analyze = request.form['text']

    # save the result of the emotion_detector function
    result = emotion_detector(text_to_analyze)

    # if the result is none then  throw a response Invalid request
    if result is None:
        return jsonify({'error': 'Invalid request'})

    # Handle the case where dominant_emotion is None
    if result.get('dominant_emotion') is None:
        return jsonify({'emotion_result': 'Invalid text! Please try again!'})

    # emotion string to create the example output
    emotion_list = [
        f"'{emotion}': {score}"
        for emotion, score in result.items()
        if emotion != 'dominant_emotion'
    ]
    emotion_str = ", ".join(emotion_list)

    # Print the appropriate system response
    response_text = (
        f"For the given statement, the system response is {emotion_str}. "
        f"The dominant emotion is {result['dominant_emotion']}."
    )

    return jsonify({'emotion_result': response_text})

if __name__ == '__main__':
    app.run(debug=True, host='localhost', port=5000)
