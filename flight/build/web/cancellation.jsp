<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Ticket Cancellation</title>
</head>
<body>
    <h1>Ticket Cancellation</h1>

    <form method="get" action="cancellation.jsp">
        <label for="ticketNo">Enter your Ticket Number:</label>
        <input type="text" name="ticketNo" id="ticketNo" required>
        <input type="submit" value="Cancel Ticket">
    </form>

    <%
        String ticketNo = request.getParameter("ticketNo");

        if (ticketNo != null && !ticketNo.isEmpty()) {
            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
                conn = DriverManager.getConnection("jdbc:derby://localhost:1527/flight", "anshu", "anshu");

                String deleteQuery = "DELETE FROM ticket WHERE ticket_no = ?";
                pstmt = conn.prepareStatement(deleteQuery);
                pstmt.setString(1, ticketNo);

                int rowsAffected = pstmt.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("<p style='color:green;'>Your ticket with number " + ticketNo + " has been successfully cancelled.</p>");
                } else {
                    out.println("<p style='color:red;'>Ticket number " + ticketNo + " not found.</p>");
                }

            } catch (ClassNotFoundException e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            } catch (SQLException e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    out.println("<p style='color:red;'>Error closing resources: " + e.getMessage() + "</p>");
                }
            }
        }
    %>

    <p><a href="index.html">Return to Home</a></p>
</body>
</html>
