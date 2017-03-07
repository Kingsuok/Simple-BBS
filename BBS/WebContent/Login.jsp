<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import="java.sql.*" %>
<%
String post = request.getParameter("action");
if (post != null && post.equals("login")){
	String name = request.getParameter("name");
	String password = request.getParameter("password");
	if (name == null || !name.equals("admin")){
		out.println("UserName is wrong!");
	}else if (password == null || !password.equals("admin")){
		out.println("Password is wrong!");
	} else {
		session.setAttribute("admin", "true");
		response.sendRedirect("ShowArticleTree.jsp");
	}
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>
	<center>
		<font size="7">BBS</font>
		<form action="Login.jsp" method="post">
		<input type="hidden" name="action" value="login">
		<label><font size="5">UserName:</font></label>
		<input type="text" name="name" size="20"><br>
        <label><font size="5">Password:</font></label>
		<input type="text" name="password" size="20"><br>
		
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  <input type="submit" value="submit">
		</form>
	</center>
</body>
</html>