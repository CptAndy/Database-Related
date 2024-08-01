
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
public class AccountantAppServlet extends HttpServlet {

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported. Please use POST.");
  }
  
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
    
    HttpSession session = request.getSession();
    String username = (String)session.getAttribute("username");
    String tempOperation=request.getParameter("opCode");
    int operation = Integer.parseInt(tempOperation);
    response.setContentType("text/html");
    PrintWriter out = response.getWriter();
   
    
    //Create a connection 
    Properties properties = new Properties();
    MysqlDataSource dataSource = null;
    Connection connection = null;
    CallableStatement cs = null;
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
      
      //If the connection is valid begin the switch case
      
      switch (operation) {
        case 1: {   
       // Get The Maximum Status Value Of All Suppliers
          cs = connection.prepareCall("{call Get_The_Maximum_Status_Of_All_Suppliers()}");
          resultSet = cs.executeQuery();
   
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
          
          break;
        }
        case 2: {   
        //TOTAL WEIGHT OF ALL PARTS
          cs = connection.prepareCall("{call Get_The_Sum_Of_All_Parts_Weights()}");
          resultSet = cs.executeQuery();
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
          
          break;
        }
        
        case 3: {   
          //TOTAL NUMBER OF SHIPMENTS
          cs = connection.prepareCall("{call Get_The_Total_Number_Of_Shipments()}");
          resultSet = cs.executeQuery();
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
          break;
        }
        
        case 4: {   
          cs = connection.prepareCall("{call Get_The_Name_Of_The_Job_With_The_Most_Workers()}");
          resultSet = cs.executeQuery();
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
          break;
        }
        
        case 5: {   
          // List The Name And Status Of All Suppliers
          cs = connection.prepareCall("{call List_The_Name_And_Status_Of_All_Suppliers()}");
          resultSet = cs.executeQuery();
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
          break;
        }
        
        
        default:
      }
      
    }
   
  } catch (SQLException e) {
    // TODO Auto-generated catch block
    e.printStackTrace();
  }
   
  
    
  }
    
  
  
  
}
