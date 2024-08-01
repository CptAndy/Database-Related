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

public class PartsInsertServlet extends HttpServlet {

  
  
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported. Please use POST.");
}
  
  
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
    HttpSession session = request.getSession();
    String username = (String)session.getAttribute("username");

    String pnum = request.getParameter("pnum");
    String pname = request.getParameter("pname");
String color = request.getParameter("color");
String tempWeight =  request.getParameter("weight");
    String city = request.getParameter("city2");
    int weight = Integer.parseInt(tempWeight);
    response.setContentType("text/html");
    PrintWriter out = response.getWriter();
    //connect to a database
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
    String insertQuery = "INSERT INTO parts (pnum, pname, color, weight, city) VALUES (?, ?, ?, ?, ?)";
    PreparedStatement ps = connection.prepareStatement(insertQuery);
    ps.setString(1,pnum);
    ps.setString(2,pname);
    ps.setString(3,color);
    ps.setInt(4, weight);
    ps.setString(5, city);
    
    
    int updatedrows = ps.executeUpdate();
    
    if(updatedrows > 0) {
      out.println("<html><body>");
      out.println("<div id=\"results\">");
      out.println("<table class=\"outputTable\">");
      out.println("<tr>");
      out.println("<th>New parts record: ("+pnum+", "+pname+", "+color+", " +weight+ ", "+city+") - successfully entered into database!</th>");
      out.println("</tr>");
      out.println("</table>");
      out.println("</div>");
      out.println("</body></html>");
    }
    
  }
} catch (SQLException e) {
  out.println("<html><body>");
  out.println("<div id=\"results\">");
  out.println("<table class=\"outputTable\">");
  out.println("<tr>");
  out.println("<th>"+e+"</th>");
  out.println("</tr>");
  out.println("</table>");
  out.println("</div>");
  out.println("</body></html>");
}  


 
    
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
