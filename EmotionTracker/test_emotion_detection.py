# Import the necessary dependencies
import unittest
from EmotionDetection import emotion_detector

# create the test based on the Factory Patterns and Object oriented principles
class TestEmotionsDetection(unittest.TestCase):

    def test_emotion_detector(self):
        test_case = [
            ('I am glad this happened', "joy"),
            ("I am really mad about this", "anger"),
            ("I feel disgusted just hearing about this", "disgust"),
            ("I am so sad about this", "sadness"),
            ("I am really afraid that this will happen", "fear")
        ]

        for text, expected_emotion in test_case:
            result = emotion_detector(text)
            self.assertIsNotNone(result)
            self.assertEqual(result['dominant_emotion'], expected_emotion)

if __name__ == '__main__':
    unittest.main()