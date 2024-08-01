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
<html lang="en">

<head>
    <style>
        body {
            text-align: center;
            background-color: black;
            color: white;
        }

        h1 {
            color: red;
        }

        h2 {
            color: aquamarine;
        }

        h3 {
            margin-top -20px;
        }

        fieldset {
            border: 2px solid white;
            padding: 20px;
            margin: 20px auto;
            display: inline-block;
            width: 90%;
        }

        legend {
            color: white;
            padding: 0 10px;
        }

        .box {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 10px;
            padding: 10px;
            border: 2px solid yellow;
            background-color: black;
        }

        .box label {
            text-align: center;
            color: aquamarine;
        }

        .box input {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid yellow;
            background-color: #8f7c39;
            color: white;
        }

        .buttons {
            grid-column: span 4;
            display: flex;
            justify-content: space-around;
            margin-top: 10px;
        }

        .buttons button {
            padding: 10px 20px;
            border: none;
            color: greenyellow;
            background-color: #8f7c39;
            cursor: pointer;
        }

        .buttons button.clear {
            background-color: red;
            cursor: pointer;
        }

        .outputTable {
            margin: 0 auto;
            /* Centers the table horizontally */
            border: 1px SOLID white;
            background: blue;
            width: 80%;
        }
     .userlog em{
            color:red;
        }
        .userlog {
            color:white;
        }
    </style>
    <script>
        function clearFormAndResults() {
    // Clear the results div
    document.getElementById('results').innerHTML = '';

    // Optionally, reset the forms
    document.getElementById('supplierForm').reset();
    document.getElementById('partsForm').reset();
    document.getElementById('jobsForm').reset(); // Change to unique ID if needed
    document.getElementById('shipmentForm').reset(); // Make sure the form ID is correct
}
        function submitForm(event, url) {
            event.preventDefault(); // Prevent the default form submission

            // Directly get values from form elements
            //<!----------------Supplier----------------->
            var snum = document.getElementById('snum').value;
            var sname = document.getElementById('sname').value;
            var status = document.getElementById('status').value;
            var city = document.getElementById('city').value;
            //<!----------------Parts----------------->
            var pnum = document.getElementById('pnum').value;
            var pname = document.getElementById('pname').value;
            var color = document.getElementById('color').value;
            var weight = document.getElementById('weight').value;
            var city2 = document.getElementById('city2').value;

            //<!----------------Jobs----------------->
            var jnum = document.getElementById('jnum').value;
            var jname = document.getElementById('jname').value;
            var numworkers = document.getElementById('numworkers').value;
            var city3 = document.getElementById('city3').value;

            //<!----------------Shipments----------------->
            var snum2 = document.getElementById('snum2').value;
            var pnum2 = document.getElementById('pnum2').value;
            var jnum2 = document.getElementById('jnum2').value;
            var quantity = document.getElementById('quantity').value;

            // Debugging: Log form data
            console.log(`snum: ${snum}`);
            console.log(`sname: ${sname}`);
            console.log(`status: ${status}`);
            console.log(`city: ${city}`);
            console.log(`pnum: ${pnum}`);
            console.log(`pname: ${pname}`);
            console.log(`color: ${color}`);
            console.log(`weight: ${weight}`);
            console.log(`jnum: ${jnum}`);
            console.log(`jname: ${jname}`);
            console.log(`numworkers: ${numworkers}`);


            // Prepare data for the server
            var params = new URLSearchParams();
            params.append('snum', snum);
            params.append('sname', sname);
            params.append('status', status);
            params.append('city', city);
            params.append('city2', city2);
            params.append('pnum', pnum);
            params.append('pname', pname);
            params.append('color', color);
            params.append('weight', weight);
            params.append('jnum', jnum);
            params.append('jname', jname);
            params.append('numworkers', numworkers);
            params.append('city3', city3);
            params.append('snum2', snum2);
            params.append('pnum2', pnum2);
            params.append('jnum2', jnum2);
            params.append('quantity', quantity);

            fetch(url, {
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

    </script>
    <title>Welcome to the Summer 2024 Project 3 Enterprise System</title>
</head>

<body>
    <h1>Welcome to the Summer 2024 Project 3 Enterprise System</h1>
    <h2>Data Entry Application</h2>
    <hr>
    <p class="userlog">
        You are connected to the project 3 Enterprise System database as a <em>data-entry-level</em> user.<br>Enter the data values in a form below to add a new record to the corresponding database table.
    </p>
    <hr>
    <!------------SUPPLIERS----------------->

    <fieldset>
        <legend>Suppliers Record Insert</legend>

        <form id="supplierForm" onsubmit="submitForm(event,'/project-3/SupplierInsertServlet')">
            <div class="box">
                <div>
                    <label for="snum">snum</label>
                    <input type="text" id="snum" name="snum" placeholder="Supplier #">
                </div>
                <div>
                    <label for="sname">sname</label>
                    <input type="text" id="sname" name="sname" placeholder="Supplier Name">
                </div>
                <div>
                    <label for="status">status</label>
                    <input type="text" id="status" name="status" placeholder="Status">
                </div>
                <div>
                    <label for="city">city</label>
                    <input type="text" id="city" name="city" placeholder="City">
                </div>
                <div class="buttons">
                    <button type="submit">Enter Supplier Record Into Database</button>
                    <button type="reset" class="clear" onclick="clearFormAndResults()">Clear Data and Results</button>
                </div>
            </div>
        </form>
    </fieldset>
    <!------------PARTS----------------->
    <fieldset>
        <legend>Parts Record Insert</legend>
        <form id="partsForm" onsubmit="submitForm(event,'/project-3/PartsInsertServlet')">
            <div class="box">
                <div>
                    <label for="pnum">pnum</label>
                    <input type="text" id="pnum" name="pnum" placeholder="Part #">
                </div>
                <div>
                    <label for="pname">pname</label>
                    <input type="text" id="pname" name="pname" placeholder="Part Name">
                </div>
                <div>
                    <label for="color">color</label>
                    <input type="text" id="color" name="color" placeholder="Color">
                </div>
                <div>
                    <label for="weight">weight</label>
                    <input type="text" id="weight" name="weight" placeholder="Weight">
                </div>
                <div>
                    <label for="city">city</label>
                    <input type="text" id="city2" name="city2" placeholder="City">
                </div>
                <div class="buttons">
                    <button type="submit">Enter Part Record Into Database</button>
                    <button type="reset" class="clear" onclick="clearFormAndResults()">Clear Data and Results</button>
                </div>
            </div>
        </form>
    </fieldset>

    <!------------JOBS----------------->
    <fieldset>
        <legend>Job(s) Record Insert</legend>
        <form id="jobsForm" onsubmit="submitForm(event,'/project-3/JobRecordInsertServlet')">
            <div class="box">
                <div>
                    <label for="jnum">jnum</label>
                    <input type="text" id="jnum" name="jnum" placeholder="Job #">
                </div>
                <div>
                    <label for="jname">jname</label>
                    <input type="text" id="jname" name="jname" placeholder="Job name">
                </div>
                <div>
                    <label for="numworkers">numworkers</label>
                    <input type="text" id="numworkers" name="numworkers" placeholder="# Of Workers">
                </div>
                <div>
                    <label for="city">city</label>
                    <input type="text" id="city3" name="city3" placeholder="City">
                </div>
                <div class="buttons">
                    <button type="submit">Enter Job Record Into Database</button>
                    <button type="reset" class="clear" onclick="clearFormAndResults()">Clear Data and Results</button>
                </div>
            </div>
        </form>
    </fieldset>

    <!------------SHIPMENTS----------------->
    <fieldset>
        <legend>Shipment(s) Record Insert</legend>
        <form id="jobsForm" onsubmit="submitForm(event,'/project-3/ShipmentRecordInsertServlet')">
            <div class="box">
                <div>
                    <label for="snum">snum</label>
                    <input type="text" id="snum2" name="snum2" placeholder="Shipment #">
                </div>
                <div>
                    <label for="pnum">pnum</label>
                    <input type="text" id="pnum2" name="pnum2" placeholder="Part #">
                </div>
                <div>
                    <label for="jnum">jnum</label>
                    <input type="text" id="jnum2" name="jnum2" placeholder="Job #">
                </div>
                <div>
                    <label for="quantity">quantity</label>
                    <input type="text" id="quantity" name="quantity" placeholder="Quantity">
                </div>
                <div class="buttons">
                    <button type="submit">Enter Shipment Record Into Database</button>
                    <button type="reset" class="clear" onclick="clearFormAndResults()">Clear Data and Results</button>
                </div>
            </div>
        </form>
    </fieldset>
    <h3>Execution Results: </h3>
    <div id="results"></div>
</body>

</html>
