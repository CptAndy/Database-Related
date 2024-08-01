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
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import com.mysql.cj.jdbc.MysqlDataSource;

@SuppressWarnings("serial")
public class RootUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported. Please use POST.");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      HttpSession session = request.getSession();
      String username = (String)session.getAttribute("username");
      String query = request.getParameter("query");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
//connect to a database
        Properties properties = new Properties();
        MysqlDataSource dataSource = null;
        Connection connection = null;
        Statement stmnt = null;
        ResultSet resultSet = null;
        try {
          InputStream filein = getServletContext().getResourceAsStream("/WEB-INF/lib/project3.properties");
        properties.load(filein);
        filein.close();
        String dbURL = properties.getProperty("MYSQL_DB_URL");
         filein = getServletContext().getResourceAsStream("/WEB-INF/lib/"+username+".properties");
         properties.load(filein);
         filein.close();
         String uN = properties.getProperty("MYSQL_DB_USERNAME");
         String pW =properties.getProperty("MYSQL_DB_PASSWORD");
dataSource = new MysqlDataSource();
dataSource.setUrl(dbURL);
dataSource.setUser(uN);
dataSource.setPassword(pW);
connection = dataSource.getConnection();
if(connection.isValid(2)) {
  /*Valid connection*/
 stmnt = connection.createStatement();  
 // Check if the query is an update/insert/delete statement
 boolean isUpdateQuery = query.trim().toUpperCase().startsWith("INSERT")
     || query.trim().toUpperCase().startsWith("UPDATE")
     || query.trim().toUpperCase().startsWith("DELETE");
if(isUpdateQuery) {
  //Business logic handling
  int businessRows = 0;
  //check if the query is inserting a supplier
 businessRows = businessLogic(query, connection);
int rowsModified = stmnt.executeUpdate(query);
if (rowsModified > 0 ) {
  out.println("<html><body>");
  out.println("<div class=\"updateBox\">");
  out.println("<h4> Successfully updated: " + rowsModified + " row(s) </h4>"); // Use e.getMessage() for a cleaner error message
  if(businessRows > 0) {
    out.println("<h4> Business Logic ACTIVE: " + businessRows + " supplier status marks. </h4>"); // Use e.getMessage() for a cleaner error message
  }
  else {
    out.println("<h4> Business Logic INACTIVE...</h4>"); // Use e.getMessage() for a cleaner error message

  }
  out.println("</div>");
  out.println("</body></html>");
}

}

else {
 resultSet = stmnt.executeQuery(query);
//Retrieve metadata to print column names
// Start HTML output
out.println("<html><body>");
out.println("<div id=\"results\">"); // Ensure id matches CSS
out.println("<table border='1' style='width:100%; border-collapse: collapse;'>");

// Print table headers
ResultSetMetaData metaData = resultSet.getMetaData();
int columnCount = metaData.getColumnCount();

out.println("<tr>");
for (int i = 1; i <= columnCount; i++) {
    out.println("<th style='border: 1px solid black; padding: 8px;'>" + metaData.getColumnName(i) + "</th>");
}
out.println("</tr>");

// Print table rows
while (resultSet.next()) {
    out.println("<tr>");
    for (int i = 1; i <= columnCount; i++) {
        out.println("<td style='border: 1px solid black; padding: 8px;'>" + resultSet.getString(i) + "</td>");
    }
    out.println("</tr>");
}

out.println("</table>");
out.println("</div>"); // Close results div
out.println("</body></html>");
} //END of isUpdateQuery ELSE
        } //End of IF
                
else {
  out.println("<h1> ERROR No connection <h1>");
}

}catch (SQLException e) {
  
  out.println("<html><body>");
  out.println("<div class=\"warningBox\">");
  out.println("<h3>" + e.getMessage() + "</h3>"); // Use e.getMessage() for a cleaner error message
  out.println("</div>");
  out.println("</body></html>");
}
        }

    private int businessLogic(String query, Connection connection) throws SQLException {
      int businessRows = 0;

      // Check if the query is an INSERT statement for the SHIPMENTS table
      if (query.toUpperCase().contains("INSERT") && query.toUpperCase().contains("SHIPMENTS")) {
          // Create a pattern to extract the quantity from the INSERT statement
          Pattern pattern = Pattern.compile("VALUES\\s*\\(\\s*[^,]+,\\s*[^,]+,\\s*[^,]+,\\s*(\\d+)\\s*\\)", Pattern.CASE_INSENSITIVE);
          Matcher insertMatch = pattern.matcher(query);
          
          if (insertMatch.find()) {
              int quantity = Integer.parseInt(insertMatch.group(1));
              
              // If the quantity >= 100, update the supplier statuses
              if (quantity >= 100) {
                  String businessLogic = "UPDATE suppliers s " +
                                         "JOIN shipments sh ON s.snum = sh.snum " +
                                         "SET s.status = s.status + 5 " +
                                         "WHERE sh.quantity >= 100";
                  try (Statement businessStmnt = connection.createStatement()) {
                      businessRows = businessStmnt.executeUpdate(businessLogic);
                  }
              }
          }
      } 
      
      // Check if the query is an UPDATE statement for the SHIPMENTS table
      else if (query.toUpperCase().contains("UPDATE") && query.toUpperCase().contains("SHIPMENTS")) {
          // Create a pattern to extract the quantity from the UPDATE statement
          Pattern patternUpdate = Pattern.compile("UPDATE\\s+shipments\\s+SET\\s+quantity\\s*=\\s*(\\d+)\\s+WHERE\\s+snum\\s*=\\s*'[^']+'\\s+AND\\s+pnum\\s*=\\s*'[^']+'\\s+AND\\s+jnum\\s*=\\s*'[^']+'", Pattern.CASE_INSENSITIVE);
          Matcher updateMatch = patternUpdate.matcher(query);
          
          if (updateMatch.find()) {
              int quantity = Integer.parseInt(updateMatch.group(1));
              
              // If the quantity >= 100, update the supplier statuses
              if (quantity >= 100) {
                  String businessLogic = "UPDATE suppliers s " +
                                         "JOIN shipments sh ON s.snum = sh.snum " +
                                         "SET s.status = s.status + 5 " +
                                         "WHERE sh.quantity >= 100";
                  try (Statement businessStmnt = connection.createStatement()) {
                      businessRows = businessStmnt.executeUpdate(businessLogic);
                  }
              }
          }
      }
      
      return businessRows;
  }
        
      

        
            
}
