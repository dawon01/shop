<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	//한글인코딩
	request.setCharacterEncoding("utf-8");


	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("[Debug] currentPage : " + currentPage);

	final int ROW_PER_PAGE = 10; // rowPerPage변수 10으로 초기화되면 끝까지 10을 써야 한다. --> 상수

	int beginRow = (currentPage - 1) * ROW_PER_PAGE;
	
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> noticeList = noticeDao.selectNoticeList(beginRow, ROW_PER_PAGE);
	
	int noticeNo = 0;
	if (request.getParameter("noticeNo") != null) {
		noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectNoticeList.jsp</title>
<link  rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<!-- 관리자 메뉴 인클루드(include)시작 ,페이지 형태만 인클루드 하는 것이 좋음(코드 형태는 비추천).-->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- 관리자 메뉴 인클루드 끝 -->
	<br>
	<div class="jumbotron">
		<h1>Notice List</h1>
		<a class="text-muted" href="<%=request.getContextPath() %>/admin/insertNoticeForm.jsp">Insert</a>
	</div>
	<br>
	<table class="table table-hover">
		<thead class="thead-dark">
			<tr>
				<th>noticeNo</th>
				<th>noticeTitle</th>
			</tr>
		</thead>
		<tbody>
			<%
				for (Notice n : noticeList) {
			%>
					<tr>
						<td><%=n.getNoticeNo()%></td>
						<td>
							<a href="<%=request.getContextPath()%>/admin/selectNoticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle()%></a>
						</td>
					</tr>
			<%
				}
			%>
			</tbody>
	</table>
	<!--  페이징 코드 -->
	<div>
		<a class="btn btn-link" href="<%=request.getContextPath()%>/admin/selectNoticeList.jsp?currentPage=1">처음으로</a>
		<%
			if (currentPage != 1) {
		%>
				<a class="btn btn-link" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=currentPage - 1%>">이전</a>
		<%
			}

			int lastPage = noticeDao.selectNoticeLastPage(10, noticeNo);

			int displayPage = 10;

			int startPage = ((currentPage - 1) / displayPage) * displayPage + 1;
			int endPage = startPage + displayPage - 1;

			for (int i = startPage; i <= endPage; i++) {
				if (endPage <= lastPage) {
		%>
					<a href="<%=request.getContextPath()%>/admin/selectNoticeList.jsp?currentPage=<%=i%>"><%=i%></a>
		<%
				} else if (endPage > lastPage) {
		%>
					<a href="<%=request.getContextPath()%>/admin/selectNoticeList.jsp?currentPage=<%=i%>"><%=i%></a>
		<%
				}
				
				if (i == lastPage) {
					break;
				}
			} 
			
			if (currentPage != lastPage) {
			%>
				<a href="<%=request.getContextPath()%>/admin/selectNoticeList.jsp?currentPage=<%=currentPage + 1%>">다음</a>
			<%
			}
			%>
		</div>
</div>
</body>
</html>