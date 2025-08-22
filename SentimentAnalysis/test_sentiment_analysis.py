from SentimentAnalysis.sentiment_analysis import sentiment_analyzer
import unittest

class TestSentimentAnalyzer(unittest.TestCase):
    def test_sentiment_analyzer(self):
        """With the function I want to check the test sentiment Web Application """
        
        # Test Case 1 for Positive Sentiment
        result_1 = sentiment_analyzer("I love working with Python")

        # Create the first test
        self.assEqual(result_1['label'], "SENT_POSITIVE")

        # Test case for Negative Sentiment
        result_2 = sentiment_analyzer('I hate working with Python')

        # Create the second test
        self.assertEqual(result['label'], 'SENT_NEGATIVE')

        # Test Case for neutral sentiment
        result_3 = sentiment_analyzer('I am neutral on Python')

        # Create the Third Test
        self.assertEqual(result_3['label'], 'SENT_NEUTRAL')
