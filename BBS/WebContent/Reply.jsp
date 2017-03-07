<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%
String id = request.getParameter("id");
String rootid = request.getParameter("rootid");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
<script type="text/javascript">
<!--
//javascript去空格函数 
function LTrim(str){ //去掉字符串 的头空格
	var i;
	for(i=0;i<str.length; i++) {
		if(str.charAt(i)!=" ") break;
	}
	str = str.substring(i,str.length);
	return str;
}

function RTrim(str){
	var i;
	for(i=str.length-1;i>=0;i--){
		if(str.charAt(i)!=" "&&str.charAt(i)!=" ") break;
	}
	str = str.substring(0,i+1);
	return str;
}
function Trim(str){

	return LTrim(RTrim(str));

}

function check() {
	if(Trim(document.reply.title.value) == "") {
		alert("please intput the title!");
		document.reply.title.focus();
		return false;
	}
	
	if(Trim(document.reply.cont.value) == "") {
		alert("plsease input the content!");
		document.reply.cont.focus();
		return false;
	}
	
	return true;
	
}
-->
</script>
</head>
<body>
	<form action="SubmitReply.jsp" name="reply" method="post" onsubmit="return check()">
		<input type="hidden" name="id" value="<%=id %>">
		<input type="hidden" name="rootid" value="<%=rootid%>">
		<table border="1">
			<tr>
				<td>
					<label>Title:</label>
					<input type="text" name="title" size="70">
				</td>
			</tr>
			<tr>
				<td>
					<label>Content:</label><br>
					<textarea cols="80" rows="12" name="cont"></textarea>
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="submit">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>