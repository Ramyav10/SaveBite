<%@ page import="java.util.List"%>
<%@ page import="com.savebite_cag.model.Donation"%>
<%@ page import="com.savebite_cag.daoimpl.DonationDAOImpl"%>

<%
DonationDAOImpl dao =
        new DonationDAOImpl();

List<Donation> donations =
        dao.getAllDonations();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Donation History</title>
<link rel="stylesheet"
href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>

<h2>Donation History</h2>

<table border="1">

<tr>
<th>ID</th>
<th>Food</th>
<th>Quantity</th>
<th>Status</th>
</tr>

<%
for(Donation d : donations){
%>

<tr>
<td><%=d.getDonationId()%></td>
<td><%=d.getFoodName()%></td>
<td><%=d.getQuantity()%></td>
<td><%=d.getDonationStatus()%></td>
</tr>

<%
}
%>

</table>

</body>
</html>