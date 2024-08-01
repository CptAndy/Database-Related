<!--
 * Name: Anderson Mota 
 * Course: CNT 4714 
 * Summer 2024 
 * Assignment title: Project 3 - Developing A Three-Tier Distributed Web-Based Application
 * Client-Server Application 
 * Date: July 30, 2024 
 * Class: Enterprise Computing
-->
<!DOCTYPE html>
<html>

<head>
    <style>
        body {
            align-content: center;
            text-align: center;
            justify-content: center;
            background-color: black;
        }

        textarea {
            width: 700px;
            height: 300px;
            background-color: blue;
            color: white;
        }

        .textBox {
            position: relative;
            display: inline-block;
            text-align: left;
        }

        .warningBox {
            background-color: red;
            border: 1px solid white;
        }

        .updateBox {
            background-color: greenyellow;
            border: 2px solid white;
        }

        h1 {
            color: red;
        }

        h2 {
            color: white;
        }

        .warningBox h3 {
            color: black;
        }

        h4 {
            color: black;
        }

        p {
            color: deepskyblue;
        }

        label {
            color: yellow;
        }

        button {
            padding: 10px 30px;
            margin: 5px;
        }

        button.executeButton {
            background-color: grey;
            color: greenyellow;
        }

        button.clearButton {
            background-color: grey;
            color: darkred;
        }

        button.clearForm {
            background-color: grey;
            color: lightsalmon;
        }

        #results {
            max-height: 200px;
            /* Set the maximum height for the scrollable area */
            overflow: auto;
            /* Enable scrollbars if content exceeds the height */
            width: 75%;
            /* Adjust the width as needed */
            margin: 0 auto;
            /* Center the box horizontally if desired */
        }
        #results th {
            /*Headers*/
            position: sticky;
            border: 1px solid black;
            background-color: red;
            top: 0;
            /* Ensure the header sticks to the top */

        }

        #results tr:nth-child(odd) {
            background-color: darkgray;
            /* Light gray background for odd rows */
        }

        #results tr:nth-child(even) {
            background-color: white;
            /* White background for even rows */
        }
           .userlog em{
            color:red;
        }
        .userlog {
            color:white;
        }
    </style>
    <script>
        function clearTextArea() {
            document.getElementById('inputArea').value = '';
        }

        function clearResults() {
            document.getElementById('results').innerHTML = '';
        }

        function executeCommand(event) {
            event.preventDefault();
            var xhr = new XMLHttpRequest();
            var query = document.getElementById('inputArea').value;
            xhr.open('POST', '/project-3/ClientUserServlet', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onload = function() {
                if (xhr.status === 200) {
                    document.getElementById('results').innerHTML = xhr.responseText;
                } else {
                    console.error('Error:', xhr.statusText);
                }
            };
            xhr.send('query=' + encodeURIComponent(query));
        }
    </script>
</head>

<body>
    <h1>Welcome to the Summer 2024 Project 3 Enterprise System</h1>
    <hr>
    <p>A Servlet/JSP-based Multi-tiered Enterprise Application Using A Tomcat Container.</p>
    <hr>
    <p class="userlog">You are conected to the Project 3 Enterprise System database as a <em>client-level</em> user.<br> Please enter any SQL query or update command in the box below.</p>
    <div class="textBox">
        <form onsubmit="executeCommand(event)">
            <label for="inputArea">Command-Line</label><br>
            <textarea id="inputArea" name="query"></textarea>
            <br>
            <button type="submit" class="executeButton">Execute Command</button>
            <button type="button" class="clearButton" onclick="clearTextArea()">Clear</button>
            <button type="button" class="clearForm" onclick="clearResults()">Clear Results</button>
        </form>
    </div>
    <hr>
    <h2>Execution Results:</h2>
    <div id="results"></div>
</body>

</html>