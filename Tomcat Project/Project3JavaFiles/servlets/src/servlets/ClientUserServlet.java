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
public class ClientUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported. Please use POST.");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        //Retrieve from prev session
        HttpSession session = request.getSession();
        String username = (String)session.getAttribute("username");
        String password = (String)session.getAttribute("password");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        Properties properties = new Properties();
        MysqlDataSource dataSource = null;
        Connection connection = null;
        Statement stmnt = null;
        ResultSet resultSet = null;
        
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
       try {
        connection = dataSource.getConnection();
        if(connection.isValid(2)) {
          stmnt = connection.createStatement();  
          /*HANDLE UPDATE STATEMENTS*/
          boolean isUpdateQuery = query.trim().toUpperCase().startsWith("INSERT")
              || query.trim().toUpperCase().startsWith("UPDATE")
              || query.trim().toUpperCase().startsWith("DELETE")
              || query.trim().toUpperCase().startsWith("REPLACE");
         if(isUpdateQuery) {
         int rowsModified = stmnt.executeUpdate(query);
         if (rowsModified > 0 ) {
           out.println("<html><body>");
           out.println("<div class=\"updateBox\">");
           out.println("<h4> Successfully updated: " + rowsModified + " row(s) </h4>"); // Use e.getMessage() for a cleaner error message
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
        }
        }
        else {
          out.println("<html><body>");
          out.println("<div id=\"results\">");
         out.println("<p> NO CONNECTION</p>");
         out.println("</div>");
         out.println("</body></html>");

        }
        
      } catch (SQLException e) {
        // TODO Auto-generated catch block
        out.println("<html><body>");
        out.println("<div class=\"warningBox\">");
        out.println("<h3>" + e.getMessage() + "</h3>"); // Use e.getMessage() for a cleaner error message
        out.println("</div>");
        out.println("</body></html>");
      }

       
    }
}
