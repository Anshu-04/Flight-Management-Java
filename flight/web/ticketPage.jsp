<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Your Ticket</title>
</head>
<body>
    <h1>Flight Ticket Details</h1>
    <p>Name: <%= request.getParameter("name") %></p>
    <p>Flight Number: <%= request.getParameter("flno") %></p>
    <p>Destination: <%= request.getParameter("destination") %></p>
    <p>Ticket Number: <%= request.getParameter("ticketNo") %></p>
    <p>Thank you for booking with us!</p>
</body>
</html>
