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
public class ShipmentRecordInsertServlet extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported. Please use POST.");
  }
  
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession();
    String username = (String)session.getAttribute("username");
    String snum = request.getParameter("snum2");
    String pnum = request.getParameter("pnum2");
    String jnum = request.getParameter("jnum2");
    String tempQuantity = request.getParameter("quantity");
    int quantity = Integer.parseInt(tempQuantity);
  
    response.setContentType("text/html");
    PrintWriter out = response.getWriter();
  
    // Connect to the database
    Properties properties = new Properties();
    MysqlDataSource dataSource = new MysqlDataSource();
    String dbURL;
    String uN;
    String pW;
  
    try (InputStream filein = getServletContext().getResourceAsStream("/WEB-INF/lib/project3.properties")) {
        properties.load(filein);
        dbURL = properties.getProperty("MYSQL_DB_URL");
    } catch (IOException e) {
        e.printStackTrace();
        out.println("<html><body>");
        out.println("<div id=\"results\">");
        out.println("<table class=\"outputTable\">");
        out.println("<tr>");
        out.println("<th>ERROR: Could not load properties file</th>");
        out.println("</tr>");
        out.println("</table>");
        out.println("</div>");
        out.println("</body></html>");
        return;
    } // End of properties file loading
    
    try (InputStream filein = getServletContext().getResourceAsStream("/WEB-INF/lib/" + username + ".properties")) {
        properties.load(filein);
        uN = properties.getProperty("MYSQL_DB_USERNAME");
        pW = properties.getProperty("MYSQL_DB_PASSWORD");
    } catch (IOException e) {
        e.printStackTrace();
        out.println("<html><body>");
        out.println("<div id=\"results\">");
        out.println("<table class=\"outputTable\">");
        out.println("<tr>");
        out.println("<th>ERROR: Could not load user properties file</th>");
        out.println("</tr>");
        out.println("</table>");
        out.println("</div>");
        out.println("</body></html>");
        return;
    } // End of user properties file loading
  
    dataSource.setUrl(dbURL);
    dataSource.setUser(uN);
    dataSource.setPassword(pW);
  
    // Use try-with-resources to automatically close Connection and PreparedStatement
    try (Connection connection = dataSource.getConnection();
        PreparedStatement ps = connection.prepareStatement("INSERT INTO shipments(snum, pnum, jnum, quantity) VALUES (?, ?, ?, ?)")) {
          
        if (connection.isValid(2)) {
          ps.setString(1, snum);
          ps.setString(2, pnum);
          ps.setString(3, jnum);
          ps.setInt(4, quantity);
          int updatedRows = ps.executeUpdate();
            boolean businessLogicFlag = false;

            if (updatedRows > 0) {
                // Row was updated
                if (quantity >= 100) {
                    businessLogicFlag = businessLogicFlag(quantity, properties, connection, businessLogicFlag);
                }

                out.println("<html><body>");
                out.println("<div id=\"results\">");
                out.println("<table class=\"outputTable\">");
                out.println("<tr>");
                out.println("<th>New shipment record: (" + snum + ", " + pnum + ", " + jnum + ", " + quantity + ") - successfully entered into database!</th>");
                if (businessLogicFlag) {
                    out.println("<p> BUSINESS LOGIC: ACTIVATED!</p>");
                } else {
                    out.println("<p> BUSINESS LOGIC: INACTIVE</p>");
                }
                out.println("</tr>");
                out.println("</table>");
                out.println("</div>");
                out.println("</body></html>");
            } else {
                // Row was not dealt with
              
                out.println("<html><body>");
                out.println("<div id=\"results\">");
                out.println("<table class=\"outputTable\">");
                out.println("<tr>");
                out.println("<th>ERROR: No matching shipment record found to update.</th>");
                out.println("</tr>");
                out.println("</table>");
                out.println("</div>");
                out.println("</body></html>");
            }
        } else {
            out.println("<html><body>");
            out.println("<div id=\"results\">");
            out.println("<table class=\"outputTable\">");
            out.println("<tr>");
            out.println("<th>ERROR!</th>");
            out.println("</tr>");
            out.println("</table>");
            out.println("</div>");
            out.println("</body></html>");
        }

    } catch (SQLException e) {
        out.println("<html><body>");
        out.println("<div id=\"results\">");
        out.println("<table class=\"outputTable\">");
        out.println("<tr>");
        out.println("<th>" + e + "</th>");
        out.println("</tr>");
        out.println("</table>");
        out.println("</div>");
        out.println("</body></html>");
        e.printStackTrace();
    } // End of database connection and statement execution
  }

  private boolean businessLogicFlag(int quantity, Properties properties,
      Connection connection, boolean businessLogicFlag) throws IOException, SQLException {
    String dbURL;
    String uN;
    String pW;
    
    MysqlDataSource dataSourceBus = new MysqlDataSource();
    
    try (InputStream filein = getServletContext().getResourceAsStream("/WEB-INF/lib/project3.properties")) {
        properties.load(filein);
        dbURL = properties.getProperty("MYSQL_DB_URL");
    } catch (IOException e) {
        e.printStackTrace();
        throw new SQLException("Could not load properties file for business logic", e);
    } // End of project3 properties file loading
    
    try (InputStream filein = getServletContext().getResourceAsStream("/WEB-INF/lib/root.properties")) {
        properties.load(filein);
        uN = properties.getProperty("MYSQL_DB_USERNAME");
        pW = properties.getProperty("MYSQL_DB_PASSWORD");
    } catch (IOException e) {
        e.printStackTrace();
        throw new SQLException("Could not load root properties file for business logic", e);
    } // End of root properties file loading
    
    dataSourceBus.setUrl(dbURL);
    dataSourceBus.setUser("root");
    dataSourceBus.setPassword(pW);
    try (Connection connectionBus = dataSourceBus.getConnection()) {
        if (connectionBus.isValid(2)) {
            String businessLogic = "UPDATE suppliers s " +
                "JOIN shipments sh ON s.snum = sh.snum " +
                "SET s.status = s.status + 5 " +
                "WHERE sh.quantity >= 100";      
            try (Statement businessStmnt = connectionBus.createStatement()) {
                int businessUpdate = businessStmnt.executeUpdate(businessLogic);
        
                // If the rows updated due to the change
                if (businessUpdate > 0) {
                    businessLogicFlag = true;
                } else {
                    // No rows changed meaning it did not happen
                    businessLogicFlag = false;
                }
            } // End of business logic statement
        }
    } catch (SQLException e) {
        e.printStackTrace();
        throw new SQLException("Error executing business logic update", e);
    } // End of business logic connection and statement execution
    
    return businessLogicFlag;
  }
  
  
}
