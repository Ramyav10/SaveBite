<%@ page import="java.util.List"%>
<%@ page import="com.savebite_cag.model.Order"%>
<%@ page import="com.savebite_cag.daoimpl.OrderDAOImpl"%>

<%
OrderDAOImpl dao = new OrderDAOImpl();

List<Order> orders = dao.getAllOrders();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Orders</title>
<link rel="stylesheet"
href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>

<h2>All Orders</h2>

<a href="adminDashboard.jsp">
Back to Dashboard
</a>

<br><br>

<table border="1">

<tr>
<th>Order ID</th>
<th>User ID</th>
<th>Total Amount</th>
<th>Payment Status</th>
<th>Tracking Status</th>
</tr>

<%
for(Order order : orders){
%>

<tr>

<td><%=order.getOrderId()%></td>

<td><%=order.getUserId()%></td>

<td><%=order.getTotalAmount()%></td>

<td><%=order.getPaymentStatus()%></td>

<td><%=order.getTrackingStatus()%></td>

</tr>

<%
}
%>

</table>

</body>
</html>