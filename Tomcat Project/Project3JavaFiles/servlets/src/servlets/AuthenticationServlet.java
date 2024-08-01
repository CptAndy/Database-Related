/*
 * Name: Anderson Mota Course: CNT 4714 Summer 2024 Assignment title: Project 3 - Developing A Three-Tier Distributed Web-Based Application
 * Client-Server Application Date: July 30, 2024 Class: Enterprise Computing
 */
package servlets;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.Properties;
import com.mysql.cj.jdbc.MysqlDataSource;

@SuppressWarnings("serial")
public class AuthenticationServlet extends HttpServlet {
  private static final boolean DEBUG = true;

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported. Please use POST.");
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
    //
    
    Boolean valid; //flag to ensure account existence
    //Parameters that is being requested
    String userInput = request.getParameter("first");
    String userPassInput = request.getParameter("password");
    
    response.setContentType("text/html");
    
    PrintWriter out = response.getWriter();
    out.println("<html><body style='color:black;'>");
    out.println("<h1>Authentication Page</h1>");
    out.println("<p>Username entered: " + userInput + "</p>");
    out.println("<p>Password entered: " + userPassInput + "</p>");
    
    valid = databaseConnection(out,userInput,userPassInput);
    
   
    out.println("Does the user exist?....: "+valid);
    
    if(valid) {
      //open a session
      HttpSession session = request.getSession();
      //Pass to the jsp
      session.setAttribute("username", userInput);
      session.setAttribute("password", userPassInput);
      out.println("---USER EXISTS---");
           if (userInput.contains("data")) { 
             response.sendRedirect("dataEntryHome.jsp"); 
            }  
           else if (userInput.contains("root")) { 
             response.sendRedirect("rootHome.jsp");           
             }  
           else if (userInput.contains("accountant")) { 
             response.sendRedirect("AccountantUserApp.jsp"); 
             }  
           else  if (userInput.contains("client")) { 
             response.sendRedirect("clientUserApp.jsp");               
             }  
           else {
        response.sendRedirect("/errorpage.html");
    }
    }//EOValid block
    else {
     
     response.sendRedirect(request.getContextPath()+"/errorpage.html");
    }
    
  }

  private Boolean databaseConnection(PrintWriter out, String userInput, String userPassInput) throws IOException {
    out.println("---<h1>Inside of databaseConnection()---</h1>");
    
    
    Properties properties = new Properties();
 
    MysqlDataSource dataSource = null;
    Connection connection = null;
    Statement statement = null;
    
    //Connect to the credentialsDB
    try {
      InputStream filein = getServletContext().getResourceAsStream("/WEB-INF/lib/credentialsDB.properties");
      properties.load(filein);
filein.close();
String dbURL = properties.getProperty("MYSQL_DB_URL");
      // dataSource.setUrl(properties.getProperty("MYSQL_DB_URL"));
      if(DEBUG) {
        out.println("URL...: " + dbURL);
      }
      
      InputStream fileUP = getServletContext().getResourceAsStream("/WEB-INF/lib/systemapp.properties");
      properties.load(fileUP);
      filein.close();
      //dataSource.setUser(properties.getProperty("MYSQL_DB_USERNAME"));
      
      //dataSource.setPassword(properties.getProperty("MYSQL_DB_PASSWORD"));
      String uN = properties.getProperty("MYSQL_DB_USERNAME");
      String pW =properties.getProperty("MYSQL_DB_PASSWORD");
      if(DEBUG) {
        
      
      out.println("username...: " + uN);
      out.println("password...: " + pW);
      }
      dataSource = new MysqlDataSource();
dataSource.setUrl(dbURL);
dataSource.setUser(uN);
dataSource.setPassword(pW);
      connection = dataSource.getConnection();
   // Check if connection is valid
      if (connection.isValid(2)) {
          out.println("Database connection successful!");
      } else {
          out.println("Database connection failed!");
          return false; // Return false if connection is not valid
      }
      statement = connection.createStatement();
    
      //Query execution
      ResultSet resultSet = null; 
      String checkUser = "select login_username,login_password "
          + "FROM usercredentials "
        + "WHERE login_username = ? AND login_password = ?";
      PreparedStatement preparedStatement = null;
      preparedStatement = connection.prepareStatement(checkUser);
      preparedStatement.setString(1, userInput);
      preparedStatement.setString(2, userPassInput);
      resultSet = preparedStatement.executeQuery();
      
      //if user was found
      if(resultSet.next()) {
        out.println("User exists");
      return true;
      }
    
      
    } catch (FileNotFoundException e) {
      // TODO Auto-generated catch block
      out.println("Properties file not found: " + e.getMessage());
    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
    return false;
  }


//    //Make a connection to the credentials db using a properties file
//    dataSource = new MysqlDataSource();
//    String databaseURL = "jdbc:mysql://localhost:3306/credentialsDB";
//    String rootUsername = "root";
//    String rootPassword = "Phodacbiet";
//    out.println("<h2>What was found in the database!</h2>");
//
//    try {
//      Connection db = DriverManager.getConnection(databaseURL, rootUsername, rootPassword);
//      //check if user exists
//      String checkUser = "select login_username,login_password from usercredentials "
//          + "WHERE login_username = ? AND login_password = ?";
//      PreparedStatement checkStatement = db.prepareStatement(checkUser);
//      checkStatement.setString(1, userInput);
//      checkStatement.setString(2, userPassInput);
//      ResultSet resultSet = checkStatement.executeQuery();
//      
//      if(resultSet.next()) {
//
//        out.println("<p>Database username: " + resultSet.getString("login_username") + "</p>");
//        out.println("<p>Database password: " + resultSet.getString("login_password") + "</p>");
//        return true;
//      } else {
//        out.println("<p>No matching credentials found in the database.</p>");
//      }
//    } catch (SQLException e) {
//      e.printStackTrace(out);
//    }
//    
//    return false;
 
  
  
  
  
  

}
