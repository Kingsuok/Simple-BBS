
<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import="java.sql.*" %>
<%
boolean admin = false;
String checkAdmin = (String)session.getAttribute("admin");
if (checkAdmin != null && checkAdmin.equals("true")){
	admin = true;
}
%>
<%!
String outResult = null;
private void tree(Connection connection, int id, int level, boolean admin){
	Statement statement = null;
	ResultSet resultSet = null;
	String showDelete = ""; 
	String preStr = "";
	for (int i = 0; i < level; i++){
		preStr += "----";
	}
	
	try {
		statement = connection.createStatement();
		String sql = "select * from article where pid =" + id;
		resultSet = statement.executeQuery(sql);
		while (resultSet.next()){
			if (admin == true){
				showDelete = "<td><a href='Delete.jsp?id="+resultSet.getInt("id") + "&pid="+ resultSet.getInt("pid")+"'>Delete</a></td>"; 
			}
			outResult += "<tr><td>"+ resultSet.getInt("id")+"</td>" + "<td>" +
						preStr + "<a href = 'ShowArticleDetail.jsp?id="+ resultSet.getInt("id") + "'>" + resultSet.getString("title") +"</a></td>"+
						showDelete+"</tr>";
			if (resultSet.getInt("isleaf") != 0){
				tree(connection,resultSet.getInt("id"), level + 1,admin);
			}
		}
	} catch (SQLException e){
		e.printStackTrace();
	} finally {
		try {
			if (statement != null){
				statement.close();
				statement = null;
			}
			if (resultSet != null){
				resultSet.close();
				resultSet = null;
			}
		} catch (SQLException e){
			e.printStackTrace();
		}
	}
}

%>


<%
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost/bbs?useUnicode=true&characterEncoding=utf-8&useSSL=false&user=root&password=root";
    Connection connection = DriverManager.getConnection(url);
    Statement statement = connection.createStatement();
    String sql = "select * from article where pid = 0";
    ResultSet resultSet = statement.executeQuery(sql);
    String showDelete = "";
    outResult = "<table border ='1'>";
    while (resultSet.next()){
    	if (admin == true){
    		showDelete = "<td><a href='Delete.jsp?id="+resultSet.getInt("id") + "&pid="+ resultSet.getInt("pid")+"'>Delete</a></td>"; 
    	}
    	outResult += "<tr><td>" + resultSet.getInt("id") + "</td>" +
    				"<td>" + "<a href = 'ShowArticleDetail.jsp?id="+ resultSet.getInt("id") + "'>" + resultSet.getString("title") +"</a></td>"+
    						showDelete +"</tr>";
    	if (resultSet.getInt("isleaf") != 0){
    		tree(connection, resultSet.getInt("id"), 1, admin );
    	}
    }
    outResult += "</table>";
    connection.close();
    connection = null;
	statement.close();
	statement = null;
	resultSet.close();
	resultSet = null;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>
<br>
<a href="Post.jsp">Post New</a><br>
<br>
<%= outResult %>
<% outResult = ""; %>
</body>
</html>