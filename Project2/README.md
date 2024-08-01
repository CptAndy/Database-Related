# Project Two: A Two-Tier Client-Server Application Using MySQL and JDBC


## Objectives
To develop a two-tier Java-based client-server application that interacts with a MySQL database utilizing JDBC for connectivity. This project aims to provide hands-on experience with JDBC features and its integration within a MySQL DB Server environment.

## Project Description
This project entails creating a Java-based GUI front-end application that connects to a MySQL server via JDBC. The application enables clients with varying permissions to execute SQL commands across different databases. Additionally, a specialized GUI monitoring application will be developed for accountant-level users.

### Detailed Description
You will build two distinct Java applications:
1. **General Client Application**: Allows general end-users to issue SQL commands against various databases through a Java GUI front-end.
2. **Specialized Accountant Application**: A restricted version tailored for accountant-level users, enabling them to view transaction logs from a separate database.

The applications will provide functionalities for executing DDL and DML commands, verifying user credentials, and maintaining transaction logs for all operations performed by different users.

## Restrictions
1. Source files must begin with specific comments detailing the author's name, course, assignment title, date, and class.
2. Applications must feature a user-friendly interface for connecting to databases and validating user credentials.
3. Non-query commands should inform users about the status of executed commands.
4. The `PreparedStatement` interface must be utilized for commands issued by client users.


## Input Specification
1. **Database Setup**: Utilize MySQL Workbench to execute scripts for creating and populating required databases.
2. **User Creation**: Establish client-level users and assign appropriate permissions.


## Additional Details
The GUI will include:
- Drop-down lists for selecting properties files.
- Connection status displays.
- Functionality for clearing command and result windows.

The application will connect to an operations log database to maintain a running tally of user queries and updates.

## High-Level Timeline
1. Ensure MySQL server is operational.
2. Create and populate the necessary databases.
3. Set up user accounts and permissions.
4. Develop the main application and the specialized accountant application.
5. Implement logging for user commands.

## Conclusion
This project serves as a practical application of Java, JDBC, and MySQL integration, highlighting skills in database management, GUI development, and application security. Through the successful implementation of this project, I have enhanced my understanding of client-server architectures and database interactions.
