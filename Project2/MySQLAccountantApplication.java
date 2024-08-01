import javax.swing.*;
import javax.swing.table.DefaultTableModel;

import java.awt.*;
import java.awt.event.*;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/*
 * Name: Anderson Mota Course: CNT 4714 Summer 2024 Assignment title: Project 2 – A Specialized
 * Accountant Application Date: July 10, 2024 Class: Enterprise Computing
 */
public class MySQLAccountantApplication extends JFrame {
  protected static final boolean DEBUG = false; // SWITCH TO TRUE FOR CHECKING PURPOSES
  private ResultSetTableModel tableModel;
  private JTextField usernameField;
  private JPasswordField passwordField;
  private JComboBox<String> databaseDropdown;
  private JComboBox<String> userDropdown;
  private JTable outputTable;
  private boolean isConnected = false;
  private String login_username = "";

  public MySQLAccountantApplication() {
    super("SQL ACCOUNTANT Application - (AM - CNT 4714 - Summer 2024 - Project 2)");

    // Database properties files and user properties files arrays
    String[] databaseURLS = {"operationslog.properties"};
    String[] userPropertiesFiles = {"theaccountant.properties"};
    getContentPane().setLayout(null);
    // Handles the connection area

    JPanel connectionAreaPanel = new JPanel();
    connectionAreaPanel.setBounds(10, 10, 405, 174);
    getContentPane().add(connectionAreaPanel);
    connectionAreaPanel.setLayout(null);

    JLabel connectionAreaLabel = new JLabel("Connection Area:");
    connectionAreaLabel.setForeground(Color.blue);
    connectionAreaLabel.setBounds(0, 0, 98, 13);
    connectionAreaPanel.add(connectionAreaLabel);

    JLabel databaseURL = new JLabel("Database URL:");
    databaseURL.setOpaque(true);
    databaseURL.setBackground(SystemColor.activeCaptionBorder);
    databaseURL.setBounds(0, 23, 98, 13);
    connectionAreaPanel.add(databaseURL);

    JLabel userPropertiesLabel = new JLabel("User Properties:");
    userPropertiesLabel.setOpaque(true);
    userPropertiesLabel.setBackground(SystemColor.activeCaptionBorder);
    userPropertiesLabel.setBounds(0, 46, 98, 13);
    connectionAreaPanel.add(userPropertiesLabel);

    JLabel usernameLabel = new JLabel("Username:");
    usernameLabel.setOpaque(true);
    usernameLabel.setBackground(SystemColor.activeCaptionBorder);
    usernameLabel.setBounds(0, 69, 98, 13);
    connectionAreaPanel.add(usernameLabel);

    JLabel passwordLabel = new JLabel("Password:");
    passwordLabel.setOpaque(true);
    passwordLabel.setBackground(SystemColor.activeCaptionBorder);
    passwordLabel.setBounds(0, 92, 98, 13);
    connectionAreaPanel.add(passwordLabel);

    usernameField = new JTextField();
    usernameField.setBounds(104, 67, 191, 16);
    connectionAreaPanel.add(usernameField);
    usernameField.setColumns(10);

    passwordField = new JPasswordField();
    passwordField.setBounds(104, 89, 191, 16);
    connectionAreaPanel.add(passwordField);

    databaseDropdown = new JComboBox<>(databaseURLS);
    databaseDropdown.setFont(new Font("Arial", Font.PLAIN, 11));
    databaseDropdown.setBounds(104, 20, 180, 19);
    connectionAreaPanel.add(databaseDropdown);

    userDropdown = new JComboBox<>(userPropertiesFiles);
    userDropdown.setFont(new Font("Arial", Font.PLAIN, 11));
    userDropdown.setBounds(104, 43, 180, 19);
    connectionAreaPanel.add(userDropdown);

    JButton connectButton = new JButton("Connect");
    connectButton.setBounds(0, 115, 105, 21);
    connectionAreaPanel.add(connectButton);

    JButton disconnectButton = new JButton("Disconnect");
    disconnectButton.setBounds(115, 115, 105, 21);
    connectionAreaPanel.add(disconnectButton);

    JLabel connectionStatusLabel = new JLabel("No Connection Established");
    connectionStatusLabel.setBounds(0, 155, 329, 19);
    connectionAreaPanel.add(connectionStatusLabel);
    connectionStatusLabel.setOpaque(true);
    connectionStatusLabel.setForeground(Color.RED);
    connectionStatusLabel.setFont(new Font("Arial", Font.PLAIN, 10));
    connectionStatusLabel.setBackground(Color.BLACK);
    // Handles the command-line where text is entered

    JPanel commandLinePanel = new JPanel();
    commandLinePanel.setBounds(437, 10, 459, 174);
    getContentPane().add(commandLinePanel);
    commandLinePanel.setLayout(null);

    JLabel commandLineLabel = new JLabel("SQL Command-line:");
    commandLineLabel.setBounds(10, 0, 378, 13);
    commandLinePanel.add(commandLineLabel);
    // Scroll pane

    JScrollPane scrollPane = new JScrollPane();
    scrollPane.setBounds(10, 23, 442, 125);
    commandLinePanel.add(scrollPane);

    JTextArea queryArea = new JTextArea();
    scrollPane.setViewportView(queryArea);

    JButton executeSQLButton = new JButton("Execute SQL Command");
    executeSQLButton.setBounds(10, 153, 192, 21);
    commandLinePanel.add(executeSQLButton);

    JButton clearButton = new JButton("Clear Command");
    clearButton.setBounds(214, 153, 192, 21);
    commandLinePanel.add(clearButton);
    // Handles the output of the commands

    JPanel outputPanel = new JPanel();
    outputPanel.setBounds(10, 208, 797, 345);
    getContentPane().add(outputPanel);
    outputPanel.setLayout(null);
    // Creating a table to display

    outputTable = new JTable();
    outputTable.setFont(new Font("Arial", Font.PLAIN, 10));
    JScrollPane outputQuery = new JScrollPane(outputTable);
    outputQuery.setBounds(0, 13, 797, 301);
    outputPanel.add(outputQuery);

    JLabel outputLabel = new JLabel("SQL Command-line Output: ");
    outputLabel.setBounds(0, 0, 797, 13);
    outputPanel.add(outputLabel);

    JButton clearOutputButton = new JButton("Clear Output");

    clearOutputButton.setBounds(0, 324, 134, 21);
    outputPanel.add(clearOutputButton);

    // Button setups
    connectButton.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        try {
          String selectedDatabaseFile = (String) databaseDropdown.getSelectedItem();
          String selectedUserFile = (String) userDropdown.getSelectedItem();

          // Read the database URL from the selected database properties file
          String databaseURL = "";
          try (BufferedReader br = new BufferedReader(new FileReader(selectedDatabaseFile))) {
            String line;
            while ((line = br.readLine()) != null) {
              if (line.startsWith("MYSQL_DB_URL")) {
                databaseURL = line.split("=")[1].trim();
              }
            }
          }

          // Read the username and password from the selected user properties file
          String fileUsername = "";
          String filePassword = "";
          try (BufferedReader br = new BufferedReader(new FileReader(selectedUserFile))) {
            String line;
            while ((line = br.readLine()) != null) {
              // Remove the unnecessary
              if (line.startsWith("MYSQL_DB_USERNAME")) {
                fileUsername = line.split("=")[1].trim();
              }
              if (line.startsWith("MYSQL_DB_PASSWORD")) {
                filePassword = line.split("=")[1].trim();
              }
            }
          }
          // Account info entered

          String usernameInput = usernameField.getText().trim();
          String passwordInput = new String(passwordField.getPassword()).trim();
          // Validation
          if (usernameInput.equals(fileUsername) && passwordInput.equals(filePassword)) {
            try {
              tableModel = new ResultSetTableModel(databaseURL, usernameInput, passwordInput);
            } catch (ClassNotFoundException e1) {
              e1.printStackTrace();
            }
            isConnected = true;
            connectionStatusLabel.setText("CONNECTED TO: " + databaseURL);
            connectionStatusLabel.setForeground(Color.YELLOW);
            connectionStatusLabel.setBackground(Color.BLACK);
            connectionStatusLabel.setOpaque(true);
            login_username = fileUsername;
            if (DEBUG) {
              System.out.println("==========VALID==========");
              System.out.println("------File Contents------");
              System.out.println("  - Username: " + fileUsername);
              System.out.println("  - Password: " + filePassword);
              System.out.println("------User Input------");
              System.out.println("  - Username: " + usernameInput);
              System.out.println("  - Password: " + passwordInput);
            }

          } else {

            connectionStatusLabel.setText("No Connection - USER CREDENTIALS DO NOT MATCH!");
            JOptionPane.showMessageDialog(MySQLAccountantApplication.this,
                "Invalid username/password!", "Authentication Error", JOptionPane.ERROR_MESSAGE);
          }
        } catch (SQLException e1) {
          JOptionPane.showMessageDialog(null, e1.getMessage(), "Database error",
              JOptionPane.ERROR_MESSAGE);
        } catch (IOException e2) {
          JOptionPane.showMessageDialog(null, e2.getMessage(), "Database error",
              JOptionPane.ERROR_MESSAGE);
        }
      }
    });

    disconnectButton.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        if (!isConnected) {
          JOptionPane.showMessageDialog(MySQLAccountantApplication.this,
              "Not connected to any database!", "Not connected", JOptionPane.ERROR_MESSAGE);
        } else {
          connectionStatusLabel.setText("NO CONNECTION ESTABLISHED");
          connectionStatusLabel.setForeground(Color.RED);
          if (tableModel != null) {
            tableModel.disconnectFromDatabase();
          }
          isConnected = false;
        }
      }
    });

    executeSQLButton.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        // If the user is not connected pop a warning
        if (!isConnected) {
          JOptionPane.showMessageDialog(MySQLAccountantApplication.this,
              "Not connected to a database...", "Connection Error", JOptionPane.ERROR_MESSAGE);
          return;
        }
        // Take user query
        String query = queryArea.getText().trim();
        if (query.isEmpty()) {
          JOptionPane.showMessageDialog(MySQLAccountantApplication.this, "Please enter a query.",
              "Query Error", JOptionPane.ERROR_MESSAGE);
          return;
        }
        try {
          // Check if the query is an update/insert/delete statement

          boolean isUpdateQuery = query.trim().toUpperCase().startsWith("INSERT")
              || query.trim().toUpperCase().startsWith("UPDATE")
              || query.trim().toUpperCase().startsWith("DELETE");

          if (isUpdateQuery) {
            // Execute the update query and get the number of affected rows
            int rowsModified = tableModel.setUpdate(query);
            if (rowsModified <= 0) {
              // Let them know there was no update

              JOptionPane.showMessageDialog(MySQLAccountantApplication.this, "FAILED TO UPDATE ROW",
                  "UPDATE ERROR", JOptionPane.ERROR_MESSAGE);
            } else {
              // There was an update rowsModified > 0
              JOptionPane.showMessageDialog(MySQLAccountantApplication.this,
                  "Update Successful... " + rowsModified + " row(s) updated", "UPDATE SUCCESS",
                  JOptionPane.INFORMATION_MESSAGE);
            }

          } else {
            // Execute the select query and update the table model
            tableModel.setQuery(query);
            outputTable.setModel(tableModel);
          }

          // Log operation that was in the query ON THE CLIENT SIDE
          // operationsLogConnection(login_username, queryArea.getText().trim());

        } catch (SQLException e3) {
          JOptionPane.showMessageDialog(MySQLAccountantApplication.this,
              "Error executing query: " + e3.getMessage(), "Query Error",
              JOptionPane.ERROR_MESSAGE);
        }
      }
    });

    clearButton.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent event) {
        // Makes it blank
        queryArea.setText("");
      }
    });
    clearOutputButton.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        // Clear the table by setting an empty model
        outputTable.setModel(new DefaultTableModel());
      }
    });
    addComponentListener(new ComponentAdapter() {
      public void componentResized(ComponentEvent e) {
        Dimension size = getContentPane().getSize();
        connectionAreaPanel.setBounds(10, 10, 294, 174);
        commandLinePanel.setBounds(314, 10, size.width - 324, 174);
        outputPanel.setBounds(10, 194, size.width - 20, size.height - 204);
      }
    });

    setSize(920, 600);
    setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    setVisible(true);
  }

  private static void operationsLogConnection(String login_username, String query) {
    boolean DEBUG = false; // SWITCH TO TRUE FOR CHECKING PURPOSES

    if (DEBUG) {
      System.out.println("Inside operations log method");
    }

    // Handling files for login
    String databaseURL = "";
    // Setting to default file to read the URL
    try (BufferedReader br = new BufferedReader(new FileReader("operationslog.properties"))) {
      String line;
      while ((line = br.readLine()) != null) {
        if (line.startsWith("MYSQL_DB_URL")) {
          databaseURL = line.split("=")[1].trim();
        }
      }
    } catch (FileNotFoundException e) {
      e.printStackTrace();
    } catch (IOException e) {
      e.printStackTrace();
    }

    String fileUsername = "";
    String filePassword = "";
    // Setting to default file to read the User info to login

    try (BufferedReader br = new BufferedReader(new FileReader("project2app.properties"))) {
      String line;
      while ((line = br.readLine()) != null) {
        if (line.startsWith("MYSQL_DB_USERNAME")) {
          fileUsername = line.split("=")[1].trim();
        }
        if (line.startsWith("MYSQL_DB_PASSWORD")) {
          filePassword = line.split("=")[1].trim();
        }
      }
    } catch (FileNotFoundException e) {
      e.printStackTrace();
    } catch (IOException e) {
      e.printStackTrace();
    }

    try (
        // Connection
        Connection connect = DriverManager.getConnection(databaseURL, fileUsername, filePassword)) {
      // checks for user existence
      String checkUser = "SELECT * FROM operationscount WHERE login_username = ?";
      try (PreparedStatement checkStatement = connect.prepareStatement(checkUser)) {
        checkStatement.setString(1, login_username + "@localhost");
        try (ResultSet rs = checkStatement.executeQuery()) {
          // If user doesn't exist insert
          if (!rs.next()) {
            // create that user in the table
            String insertUser =
                "INSERT INTO operationscount (login_username, num_queries, num_updates) VALUES (?, ?, ?)";
            try (PreparedStatement insertStatement = connect.prepareStatement(insertUser)) {
              insertStatement.setString(1, login_username + "@localhost");
              insertStatement.setInt(2, 0);
              insertStatement.setInt(3, 0);
              insertStatement.executeUpdate();

              if (DEBUG) {
                System.out.println(
                    "Command executed...: INSERTED NEW USER: " + login_username + "@localhost");
              }
            }
          }
        }
      }

      // Check if it was an UPDATE statement returns true/false
      boolean queryCheck = query.toUpperCase().startsWith("UPDATE");
      // If using update statement
      if (queryCheck) {
        // Prepare a statement to increment update
        String updateUser =
            "UPDATE operationscount SET num_updates = num_updates + 1 WHERE login_username = ?";
        try (PreparedStatement updateCount = connect.prepareStatement(updateUser)) {
          if (DEBUG) {
            System.out.println("------------UPDATE INCREMENT------------");
            System.out.println(
                "UPDATE operationscount SET num_updates = num_updates + 1 WHERE login_username = "
                    + login_username + "@localhost");
          }
          updateCount.setString(1, login_username + "@localhost");
          updateCount.executeUpdate();
        }
      } else {
        // Prepare a statement to increment query
        String updateUser =
            "UPDATE operationscount SET num_queries = num_queries + 1 WHERE login_username = ?";
        try (PreparedStatement updateCount = connect.prepareStatement(updateUser)) {
          if (DEBUG) {
            System.out.println("------------QUERY INCREMENT------------");
            System.out.println(
                "UPDATE operationscount SET num_queries = num_queries + 1 WHERE login_username = "
                    + login_username + "@localhost");
          }
          updateCount.setString(1, login_username + "@localhost");
          updateCount.executeUpdate();
        }
      }

      if (DEBUG) {
        System.out.println("Database URL: " + databaseURL);
        System.out.println("Username: " + fileUsername);
        System.out.println("Password: " + filePassword);
        System.out.println("Successful login");
        System.out.println("Username...: " + login_username);
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  public static void main(String[] args) {

    new MySQLAccountantApplication();

  }
}
