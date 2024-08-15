<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<%
    String flno = request.getParameter("flno");
    String airline = request.getParameter("an");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
        conn = DriverManager.getConnection("jdbc:derby://localhost:1527/flight", "anshu", "anshu");

        String sql = "INSERT INTO flight (flno, airline) VALUES (?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(flno));
        pstmt.setString(2, airline);
        pstmt.executeUpdate();

        // Redirect to View.jsp after insertion
        response.sendRedirect("View.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
