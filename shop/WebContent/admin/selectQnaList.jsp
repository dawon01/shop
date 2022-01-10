<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	//한글인코딩
	request.setCharacterEncoding("utf-8");
	// 
	Member loginMember = (Member)session.getAttribute("loginMember");
	// 페이징 코드
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("[Debug] currentPage : " + currentPage);
	
	final int ROW_PER_PAGE = 10; // rowPerPage변수 10으로 초기화되면 끝까지 10을 써야 한다. --> 상수
	
	int beginRow = (currentPage - 1) * ROW_PER_PAGE;
	// 메서드 호출
	QnaDao qnaDao = new QnaDao();
	ArrayList<Qna> qnaList = qnaDao.selectQnaListByAdmin(beginRow, ROW_PER_PAGE);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link  rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<!-- mainMenu 인클루드(include) 시작 -->
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- mainMenu 인클루드 끝 -->
	<h1>QnA List</h1>
	<table class="table table-hover">
		<thead class="thead-dark">
			<th>No</th>
			<th>Category</th>
			<th>Title</th>
			<th>Secret</th>
			<th>Answer</th>
		</thead>
		<tbody>
			<%
				for(Qna q : qnaList){
			%>
					<tr>
						<td><%=q.getQnaNo() %></td>
						<td><%=q.getQnaCategory() %></td>
						<td><a href="<%=request.getContextPath() %>/admin/selectQnaOne.jsp?qnaNo=<%=q.getQnaNo() %>"><%=q.getQnaTitle() %></a></td>
						<td><%=q.getQnaSecret() %></td>
						<td><%=q.getQnaAnswer() %></td>
					</tr>
			<%
				}
			%>
		</tbody>
	</table>
</div>
	
	<!-- 페이징 -->
</body>
</html>