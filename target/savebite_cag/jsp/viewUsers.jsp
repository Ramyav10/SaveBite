<%@ page import="java.util.List"%>
<%@ page import="com.savebite_cag.model.User"%>
<%@ page import="com.savebite_cag.daoimpl.UserDAOImpl"%>

<%
UserDAOImpl dao = new UserDAOImpl();

List<User> users = dao.getAllUsers();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Users</title>
<link rel="stylesheet"
href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>

<h2>All Users</h2>

<a href="adminDashboard.jsp">
Back to Dashboard
</a>

<br><br>

<table border="1">

<tr>
<th>User ID</th>
<th>Name</th>
<th>Email</th>
<th>Phone</th>
<th>Role</th>
</tr>

<%
for(User user : users){
%>

<tr>

<td><%=user.getUserId()%></td>

<td><%=user.getFullName()%></td>

<td><%=user.getEmail()%></td>

<td><%=user.getPhoneNumber()%></td>

<td><%=user.getRole()%></td>

</tr>

<%
}
%>
<p>Total Users Found: <%=users.size()%></p>
</table>

</body>
</html>