package mypack;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Booking extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<html><head><title>Bookings</title></head>");

        String name = request.getParameter("name");
        String flno = request.getParameter("flno");
        String destination = request.getParameter("des");

        if (name == null || flno == null || destination == null ||
            name.isEmpty() || flno.isEmpty() || destination.isEmpty()) {
            out.println("<body bgcolor='red'>");
            out.println("<h1>Invalid input</h1>");
            out.println("</body></html>");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/flight", "anshu", "anshu");

            String query = "SELECT flno, destination FROM flight WHERE flno = ? AND destination = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, flno);
            pstmt.setString(2, destination);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // Generate a ticket number
                String ticketNo = "TCK" + System.currentTimeMillis();

                // Insert the ticket into the database
                String insertQuery = "INSERT INTO ticket (name, flno, destination, ticket_no) VALUES (?, ?, ?, ?)";
                pstmt = conn.prepareStatement(insertQuery);
                pstmt.setString(1, name);
                pstmt.setString(2, flno);
                pstmt.setString(3, destination);
                pstmt.setString(4, ticketNo);
                pstmt.executeUpdate();

                // Redirect to the ticket page with ticket details
                response.sendRedirect("ticketPage.jsp?ticketNo=" + ticketNo + "&name=" + name + "&flno=" + flno + "&destination=" + destination);
            } else {
                out.println("<body bgcolor='red'>");
                out.println("<h1>Flight " + flno + " is not available for the specified destination.</h1>");
            }

        } catch (ClassNotFoundException | SQLException e) {
            out.println("<body bgcolor='red'>");
            out.println("<h1>Error: " + e.getMessage() + "</h1>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                out.println("<h1>Error closing resources: " + e.getMessage() + "</h1>");
            }
            out.println("</body></html>");
        }
    }
}
