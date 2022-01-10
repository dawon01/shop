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
<meta charset="UTF-8" content="width=device-width">
<title>selectNoticeList.jsp</title>
<link  rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<h1>Notice List</h1>
	<br>
	<table class="table table-hover">
		<thead class="thead-dark">
			<tr>
				<th>No</th>
				<th>Title</th>
			</tr>
		</thead>
		<tbody>
			<%
				for (Notice n : noticeList) {
			%>
					<tr>
						<td><%=n.getNoticeNo()%></td>
						<td>
							<a href="<%=request.getContextPath()%>/selectNoticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle()%></a>
						</td>
					</tr>
			<%
				}
			%>
			</tbody>
	</table>
	<!-- 페이징 -->
	<div>
		<a class="btn btn-link" href="<%=request.getContextPath()%>/selectNoticeList.jsp?currentPage=1">처음으로</a>
		<%
			if (currentPage != 1) {
		%>
				<a class="btn btn-link" href="<%=request.getContextPath()%>/selectNoticeList.jsp?currentPage=<%=currentPage - 1%>">이전</a>
		<%
			}

			int lastPage = noticeDao.selectNoticeLastPage(10, noticeNo);

			int displayPage = 10;

			int startPage = ((currentPage - 1) / displayPage) * displayPage + 1;
			int endPage = startPage + displayPage - 1;

			for (int i = startPage; i <= endPage; i++) {
				if (endPage <= lastPage) {
		%>
					<a href="<%=request.getContextPath()%>/selectNoticeList.jsp?currentPage=<%=i%>"><%=i%></a>
		<%
				} else if (endPage > lastPage) {
		%>
					<a href="<%=request.getContextPath()%>/selectNoticeList.jsp?currentPage=<%=i%>"><%=i%></a>
		<%
				}
				
				if (i == lastPage) {
					break;
				}
			} 
			
			if (currentPage != lastPage) {
			%>
				<a href="<%=request.getContextPath()%>/selectNoticeList.jsp?currentPage=<%=currentPage + 1%>">다음</a>
			<%
			}
			%>
		</div>
</div>
</body>
</html>