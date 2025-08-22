import json
import requests

def emotion_detector(text_to_analyze):
    """Detects emotions in the give text using the Watchon NLP Library to make a Prection of the Emotions

    Arguements: 
        text_to_analyze(str): The text that the user will inputs that will ask for emotion analysis

    Returns:
        str: The text attribute of the response object, or None if an error occurs  
    """

    # utilize the give url of the pretrained model
    url = 'https://sn-watson-emotion.labs.skills.network/v1/watson.runtime.nlp.v1/NlpService/EmotionPredict'

    # Which model is being utilized
    headers = {"grpc-metadata-mm-model-id": "emotion_aggregated-workflow_lang_en_stock"}

    # Text for analysis / Input Text
    input_json = {"raw_document": {"text": text_to_analyze}}

    try:
        response = requests.post(url, headers = headers , json = input_json)
        
        # Raise a type of Error Bad error for bad responses
        response.raise_for_status()

        # Pass the response in a variable
        result = response.json()

        # Print APis Raw response
        #print("Raw API Response:", result) # Debug print

        # Check the result and return the result or handle the case where the emotion prediction is missing
        if 'emotionPredictions' in result and result['emotionPredictions']:
            emotion_predictions = result['emotionPredictions']
            if emotion_predictions:
                first_prediction = emotion_predictions[0]
                if 'emotion' in first_prediction:
                    emotions = first_prediction['emotion']
                    anger_score = emotions.get('anger', 0)
                    disgust_score = emotions.get('disgust', 0)
                    fear_score = emotions.get("fear", 0)
                    joy_score = emotions.get('joy', 0)
                    sadness_score = emotions.get('sadness', 0)
                    
                    dominant_emotion = max(emotions, key = emotions.get)
                    return{
                        'anger': anger_score,
                        'disgust': disgust_score,
                        'fear': fear_score,
                        'joy': joy_score,
                        'sadness': sadness_score,
                        'dominant_emotion': dominant_emotion
                    }
                else:
                    return None
            else:
                return None
        else:
            return None

    except requests.exceptions.RequestException as e:
        if 'response' in locals() and response.status_code == 400:
          return {
              'anger': None,
              'disgust': None,
              'fear': None,
              'joy': None,
              'sadness': None,
              'dominant_emotion': None
          }
        print(f"Error during request: {e}")
        return None
    except json.JSONDecodeError as e:
        print(f"Error decoding JSON response: {e}")
        return None
    except KeyError as e:
        print(f"KeyError: {e}")
        return None