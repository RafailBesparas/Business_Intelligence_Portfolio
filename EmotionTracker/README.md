# Emotion Detection Application

The application I developed in the IBM Applied DevOps provides emotion detection functionality using the Watson NLP Library. It allows users to input text and receive an analysis of the dominant emotion and associated emotion scores.

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [Files](#files)
- [Testing](#testing)
- [Dependencies](#dependencies)
- [Error Handling](#error-handling)
- [API Usage](#api-usage)

## Installation
1.  **Clone the repository:**
    ```bash
    git clone <repository_url>
    cd <repository_directory>
    ```

2.  **Create a virtual environment (recommended):**
    ```bash
    python3 -m venv venv
    source venv/bin/activate  # On macOS and Linux
    venv\Scripts\activate  # On Windows    ```

3.  **Install the required dependencies:**

    ```bash
    pip install Flask requests
    ```

## Usage
1.  **Run the Flask application:**
    ```bash
    python server.py
    ```

2.  **Open a web browser and navigate to `http://localhost:5000`.**
3.  **Enter the text you want to analyze in the provided input field.**
4.  **Click the "Run Sentiment Analysis" button.**
5.  **The system's response, including the dominant emotion and emotion scores, will be displayed below the button.**

## Files

-   **`EmotionDetection.py`:**
    -      Contains the `emotion_detector` function, which interfaces with the Watson NLP API to perform emotion analysis.
    -      Handles API requests, response parsing, and error handling.
-   **`server.py`:**
    -      A Flask application that serves the web interface and handles emotion detection requests.
    -      Defines routes for the home page and the emotion detection endpoint.
    -   Renders the index.html file and returns the json result from the emotion detection.
-   **`test_detection.py`:**
    -      Contains unit tests for the `emotion_detector` function.
    -      Uses the `unittest` framework to verify the accuracy of emotion detection.
-   **`mywebscript.js`:**
    -      JavaScript code that handles the client-side interaction with the Flask application.
    -      Sends POST requests to the `/emotionDetector` endpoint and updates the web page with the response.
-   **`index.html`:**
    -      The HTML template for the web interface.
    -      Contains the input field for text analysis and the display area for the system response.
    -   Uses bootstrap for styling.

## Testing

To run the unit tests, execute the following command:

```bash
python test_detection.py
