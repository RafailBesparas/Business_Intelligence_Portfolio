let RunSentimentAnalysis = () => {
    let textToAnalyze = document.getElementById("textToAnalyze").value;

    let xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            try {
                let response = JSON.parse(xhttp.responseText);
                document.getElementById("system_response").innerHTML = response.emotion_result;
            } catch (error) {
                console.error("Error parsing JSON:", error);
                document.getElementById("system_response").innerHTML = "Error processing response.";
            }
        }
    };
    xhttp.open("POST", "/emotionDetector", true);
    xhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhttp.send("text=" + encodeURIComponent(textToAnalyze));
};