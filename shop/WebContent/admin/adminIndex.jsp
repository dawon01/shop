<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.ArrayList" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> newNoticeList = noticeDao.selectNewNoticeList();
	
	QnaDao qnaDao = new QnaDao();
	ArrayList<Qna> noAnswerList = qnaDao.selectNoAnswerQuestionList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link  rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
	<!-- 관리자 메뉴 include -->
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<div class="jumbotron">
		<h1>Admin Page</h1>
		<p><%=loginMember.getMemberId()%>님 반갑습니다.</p>
	</div>
	<!-- 최근 공지사항 5개 -->
	<h3>Notice</h3>
	<table class="table table-hover">
		<thead class="thead-dark">
			<th>No</th>
			<th>Title</th>
		</thead>
		<tbody>
			<%
				for(Notice n : newNoticeList){
			%>
					<tr>						
						<td><%=n.getNoticeNo()%></td>
						<td><a href="<%=request.getContextPath()%>/admin/selectNoticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle()%></a></td>
					</tr>	
			<%	
				}
			%>
		</tbody>
	</table>
	<!-- 답변 없는 Q 목록 -->
	<h3>Question List</h3>
	<table class="table table-hover">
		<thead class="thead-dark">
			<th>Q.No</th>
			<th>M.No</th>
			<th>Title</th>
			<th>Secret</th>
		</thead>
		<tbody>
			<%
				for(Qna q : noAnswerList){
			%>
					<tr>
						<td><%=q.getQnaNo() %></td>
						<td><%=q.getMemberNo() %></td>
						<td><a href="<%=request.getContextPath() %>/admin/selectQnaOne.jsp?qnaNo=<%=q.getQnaNo() %>&memberNo=<%=q.getMemberNo() %>"><%=q.getQnaTitle() %></a></td>
						<td><%=q.getQnaSecret() %></td>
					</tr>
			<%
				}
			%>
		</tbody>
	</table>
</div>
</body>
</html>