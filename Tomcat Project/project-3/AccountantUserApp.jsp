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

<style>
    html,
    body {
        height: 100%;
    }

    html {
        display: table;
        margin: auto;
    }

    body {
        display: table-cell;
        vertical-align: middle;
        background-color: black;
    }

    h1 {
        text-align: center;
        color: yellow;
    }

    h2 {
        text-align: center;
        color: white;
    }

    hr {
        margin-top: 10px;
        margin-bottom: 10px
    }

    p {
        text-align: center;
        color: lawngreen;
    }

    p.userLog {
        text-align: center;
        color: white;
    }

    p.userLog em {
        color: red;
    }

    .box {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 10px;
        padding: 10px;
        background-color: gray;
        color: blue;
    }

    #results {
        max-height: 200px;
        overflow: auto;
        width: 75%;
        margin: 0 auto;

    }

    #results th {
        position: sticky;
        border: 1px solid black;
        background-color: red;
        top: 0;
        
    }
    #results tr:nth-child(odd) {
        background-color: darkgray;
    }

    #results tr:nth-child(even) {
        background-color: white;
    }
</style>

<body>
    <script>
        function clearResults() {
            document.getElementById('results').innerHTML = '';
        }

        function submitForm(event) {
            event.preventDefault(); // Prevent the default form submission

            // Retrieve the selected radio button value
            const selectedOperation = document.querySelector('input[name="opCode"]:checked');

            if (!selectedOperation) {
                alert('Please select an operation.');
                return;
            }

            const operationValue = selectedOperation.value;

            // Prepare data for the server
            const params = new URLSearchParams();
            params.append('opCode', operationValue);

            // Send the AJAX request
            fetch('/project-3/AccountantAppServlet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: params.toString()
                })
                .then(response => response.text())
                .then(data => {
                    document.getElementById('results').innerHTML = data;
                })
                .catch(error => console.error('Error:', error));
        }

        // Attach the submitForm function to the form's submit event
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('AccountantForm').addEventListener('submit', submitForm);
        });
    </script>

    <h1>Welcome to the Summer 2024 Project 3 Enterprise System</h1>
    <p>A Servlet/JSP-based Multi-Tiered Enterprise Application Using a Tomcat Container</p>
    <hr>
    <p class="userLog">You are connected to the Project 3 Enterprise System database as an <em>accountant-level</em> user.</p>
    <p class="userLog">Please select the operation you would like to perform from the list below.</p>
    <div class="box">
        <form id='AccountantForm'>
            <input type="radio" id="maxValue" name="opCode" value="1">
            <label for="maxValue">Get The Maximum Status Value Of All Suppliers</label><br>
            <br>
            <input type="radio" id="partWeight" name="opCode" value="2">
            <label for="partWeight">Get The Total Weight Of All Parts</label><br>
            <br>
            <input type="radio" id="shipmentNum" name="opCode" value="3">
            <label for="shipmentNum">Get The Total Number Of Shipments</label><br>
            <br>
            <input type="radio" id="workerInfo" name="opCode" value="4">
            <label for="workerInfo">Get The Name and Number Of Workers Of The Job With The Most Workers</label><br>
            <br>
            <input type="radio" id="suppStatus" name="opCode" value="5">
            <label for="suppStatus">List The Name And Status Of Every Supplier</label><br>
            <br>

            <input type="submit" value="Submit">
            <button type="button" onclick="clearResults()">Clear Results</button>
        </form>
    </div>
    <hr>
    <h2>Execution Results:</h2>
    <div id="results"></div>
</body>

</html>