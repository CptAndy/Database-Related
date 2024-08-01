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
public class SupplierInsertServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported. Please use POST.");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String snum = request.getParameter("snum");
        String sname = request.getParameter("sname");
        String tempStatus = request.getParameter("status");
        String city = request.getParameter("city");
        int status = Integer.parseInt(tempStatus);

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        Properties properties = new Properties();
        MysqlDataSource dataSource = new MysqlDataSource();
        String dbURL;
        String uN;
        String pW;

        // Load properties from files
        try (InputStream filein = getServletContext().getResourceAsStream("/WEB-INF/lib/project3.properties")) {
            properties.load(filein);
            dbURL = properties.getProperty("MYSQL_DB_URL");
        }

        try (InputStream filein = getServletContext().getResourceAsStream("/WEB-INF/lib/" + username + ".properties")) {
            properties.load(filein);
            uN = properties.getProperty("MYSQL_DB_USERNAME");
            pW = properties.getProperty("MYSQL_DB_PASSWORD");
        }

        dataSource.setUrl(dbURL);
        dataSource.setUser(uN);
        dataSource.setPassword(pW);

        // Use try-with-resources to automatically close Connection and PreparedStatement
        try (Connection connection = dataSource.getConnection();
             PreparedStatement ps = connection.prepareStatement("INSERT INTO suppliers (snum, sname, status, city) VALUES (?, ?, ?, ?)")) {

            if (connection.isValid(2)) {
                ps.setString(1, snum);
                ps.setString(2, sname);
                ps.setInt(3, status);
                ps.setString(4, city);

                int updatedRows = ps.executeUpdate();

                if (updatedRows > 0) {
                    out.println("<html><body>");
                    out.println("<div id=\"results\">");
                    out.println("<table class=\"outputTable\">");
                    out.println("<tr>");
                    out.println("<th>New supplier record: (" + snum + ", " + sname + ", " + status + ", " + city + ") - successfully entered into database!</th>");
                    out.println("</tr>");
                    out.println("</table>");
                    out.println("</div>");
                    out.println("</body></html>");
                }
            } else {
                out.println("<html><body>");
                out.println("<h1>ERROR: No connection</h1>");
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
        }
    }
}
