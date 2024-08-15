<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>View Tickets</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>View Tickets</h1>

    <table>
        <thead>
            <tr>
                <th>Name</th>
                <th>Flight Number (Flno)</th>
                <th>Ticket Number</th>
                <th>Destination</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
                    conn = DriverManager.getConnection("jdbc:derby://localhost:1527/flight", "anshu", "anshu");

                    String query = "SELECT name, flno, ticket_no, destination FROM ticket";
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        String name = rs.getString("name");
                        String flno = rs.getString("flno");
                        String ticketNo = rs.getString("ticket_no");
                        String destination = rs.getString("destination");
            %>
                        <tr>
                            <td><%= name %></td>
                            <td><%= flno %></td>
                            <td><%= ticketNo %></td>
                            <td><%= destination %></td>
                        </tr>
            <%
                    }
                } catch (ClassNotFoundException e) {
                    out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                } catch (SQLException e) {
                    out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        out.println("<p style='color:red;'>Error closing resources: " + e.getMessage() + "</p>");
                    }
                }
            %>
        </tbody>
    </table>

    <p><a href="index.html">Return to Home</a></p>
</body>
</html>
