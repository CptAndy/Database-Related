# Project Three: Developing A Three-Tier Distributed Web-Based Application

## Overview

This project aims to create a distributed three-tier web-based application using servlets and JSP technology. The application runs on a Tomcat server and connects to a MySQL database using JDBC. It is designed to manage a suppliers/parts/jobs/shipments database, allowing different users to interact with the data effectively.

## Project Objectives

- **Develop a web application** that authenticates users and provides access to a MySQL database.
- **Implement business logic** to manage supplier statuses based on shipment records.
- **Create user interfaces** for different user roles including root, client, data entry, and accountant levels.

## Technologies Used

- **Frontend:** HTML, JSP
- **Backend:** Java Servlets
- **Database:** MySQL
- **Server:** Apache Tomcat

## Database Schema

The application utilizes a MySQL database with the following tables:

- **suppliers:** `snum`, `sname`, `status`, `city`
- **parts:** `pnum`, `pname`, `color`, `weight`, `city`
- **jobs:** `jnum`, `jname`, `numworkers`, `city`
- **shipments:** `snum`, `pnum`, `jnum`, `quantity`

Referential integrity is enforced through foreign key constraints, ensuring that shipment records link back to existing suppliers, parts, and jobs.

## User Roles

### 1. **Root User**
- Access to all functionalities, including direct SQL command entry.
- Can manage supplier statuses and run reports.

### 2. **Client User**
- Limited to selecting data.
- Cannot perform updates or business logic.

### 3. **Data Entry User**
- Can enter data through forms without direct SQL command entry.
- Uses prepared statements for secure data handling.

### 4. **Accountant User**
- Access to reports generated via stored procedures.
- Executes predefined queries for financial reporting.

## Project Structure

Project-3/
├── webapps/
│ └── Project-3/
│ ├── WEB-INF/
│ │ ├── classes/
│ │ │ └── servlets/
│ │ └── lib/
│ ├── authenticate.html
│ ├── rootHome.jsp
│ ├── clientHome.jsp
│ ├── dataEntryHome.jsp
│ └── accountantHome.jsp
├── project3db.sql
├── project3UserCredentialsScript.sql
└── ClientCreationPermissionsScript.sql

## Setup Instructions

1. **Install Tomcat** and ensure it is configured correctly.
2. **Create the MySQL database** by running the `project3db.sql` script.
3. **Set up user credentials** using `project3UserCredentialsScript.sql`.
4. **Run the permissions script** `ClientCreationPermissionsScript.sql` to set user roles.
5. **Deploy the web application** to the Tomcat server and access it via a web browser.

## Screenshots
<p>Login Screen</p>

![Alt text](https://github.com/CptAndy/Database-Related/blob/main/Tomcat%20Project/loginscreen.png?raw=true)


<br>

<p>Invalid Credentials</p>

![Alt text](https://github.com/CptAndy/Database-Related/blob/main/Tomcat%20Project/invalidLogin.png?raw=true)


<br>
<p>Root user UI query</p>

![Alt text](https://github.com/CptAndy/Database-Related/blob/main/Tomcat%20Project/rootuserUI.png?raw=true)


<br>
<p>Client UI showing permission denied for admin queries</p>

![Alt text](https://github.com/CptAndy/Database-Related/blob/main/Tomcat%20Project/clientUI.png?raw=true)

<br>
<p>Data Entry UI</p>

![Alt text](https://github.com/CptAndy/Database-Related/blob/main/Tomcat%20Project/dataEntryUI1-2.png?raw=true)
![Alt text](https://github.com/CptAndy/Database-Related/blob/main/Tomcat%20Project/dataEntryUI2-2.png?raw=true)

<br>
<p>The Accountant UI</p>

![Alt text](https://github.com/CptAndy/Database-Related/blob/main/Tomcat%20Project/theaccountantUI.png?raw=true)
<br>

## Conclusion

This project showcases my ability to integrate multiple technologies into a cohesive application. It demonstrates my understanding of web development, database management, and user authentication principles.

---
