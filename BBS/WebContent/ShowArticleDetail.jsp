<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import="java.sql.*" %>
<%
String id = request.getParameter("id");
Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://localhost/bbs?useUnicode=true&characterEncoding=utf-8&useSSL=false&user=root&password=root";
Connection connection = DriverManager.getConnection(url);
Statement statement = connection.createStatement();
String sql = "select * from article where id =" + id;
ResultSet resultSet = statement.executeQuery(sql);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>
	<table border="1">
		<%
		if (resultSet.next()){
		%>
			<tr>
				<td>ID</td>
				<td><%=resultSet.getInt("id") %></td>
			</tr>
			<tr>
				<td>title</td>
				<td><%=resultSet.getString("title") %></td>
			</tr>
			<tr>
				<td>content</td>
				<td><%=resultSet.getString("cont") %></td>
			</tr>
		<%	
		}
		%>
	</table>
	<br>
	<a href="Reply.jsp?id=<%=resultSet.getInt("id")%>&rootid=<%=resultSet.getInt("rootid")%>">Reply</a>
</body>
<%
connection.close();
connection = null;
statement.close();
statement = null;
resultSet.close();
resultSet = null;
%>
</html>