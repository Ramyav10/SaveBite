<%@ page import="java.util.List"%>
<%@ page import="com.savebite_cag.model.Donation"%>
<%@ page import="com.savebite_cag.daoimpl.DonationDAOImpl"%>

<%
DonationDAOImpl dao = new DonationDAOImpl();

List<Donation> donations =
        dao.getAllDonations();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Donations</title>
<link rel="stylesheet"
href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>

<h2>All Donations</h2>

<a href="adminDashboard.jsp">
Back to Dashboard
</a>

<br><br>

<table border="1">

<tr>
<th>Donation ID</th>
<th>Restaurant</th>
<th>Food Name</th>
<th>Quantity</th>
<th>Pickup Address</th>
<th>Expiry Time</th>
<th>Status</th>
</tr>

<%
for(Donation d : donations){
%>

<tr>

<td><%=d.getDonationId()%></td>

<td><%=d.getRestaurantName()%></td>

<td><%=d.getFoodName()%></td>

<td><%=d.getQuantity()%></td>

<td><%=d.getPickupAddress()%></td>

<td><%=d.getExpiryTime()%></td>

<td><%=d.getDonationStatus()%></td>

</tr>

<%
}
%>

</table>

</body>
</html>