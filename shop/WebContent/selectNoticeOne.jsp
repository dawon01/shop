<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	//한글인코딩
	request.setCharacterEncoding("utf-8");
	
	if(request.getParameter("noticeNo") == null){
		response.sendRedirect(request.getContextPath()+"/selectNoticeList.jsp");
		return;
	}
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectNoticeOne.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<!-- mainMenu 인클루드(include) 시작 -->
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- mainMenu 인클루드 끝 -->
	<h2>Notice ReadMore</h2>
	<br>
	<%
		NoticeDao noticeDao = new NoticeDao();
		Notice notice = noticeDao.selectNoticeOne(noticeNo);
	%>
	<table class="table table-striped">
		<tr>
			<td>no</td>
			<td><%=notice.getNoticeNo() %></td>
		</tr>
		<tr>
			<td>title</td>
			<td><%=notice.getNoticeTitle() %></td>
		</tr>
		<tr>
			<td>content</td>
			<td><%=notice.getNoticeContent() %></td>
		</tr>
	</table>
	<a class="btn btn-link" href="<%=request.getContextPath() %>/selectNoticeList.jsp?currentPage=1">Back</a>	
</div>	
</body>
</html>