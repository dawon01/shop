<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	//한글인코딩
	request.setCharacterEncoding("utf-8");
	
	Member loginMember = (Member) session.getAttribute("loginMember");
	// 방어 코드 : qnaNo 값이 null이면 selectQuestionList.jsp로 이동
	if(request.getParameter("qnaNo") == null){
		response.sendRedirect(request.getContextPath()+"/selectQuestionList.jsp");
		return;
	}
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectQnaOne.jsp</title>
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
	<h3>Qna 상세보기</h3>
	<br>
	<%
		QnaDao qnaDao = new QnaDao();
		Qna qna = qnaDao.selectQuestionOne(qnaNo);
		QnaCommentDao qnaCommentDao = new QnaCommentDao();
		QnaComment qnaComment = new QnaComment();
	%>
	<!-- Question 상세 보기 -->
	<table class="table">
		<tr>
			<td class="table-dark" width="100px">No :</td>
			<td><%=qna.getQnaNo() %></td>
		</tr>
		<tr>
			<td class="table-dark" width="100px">Category :</td>
			<td><%=qna.getQnaCategory() %></td>
		</tr>
		<tr>
			<td class="table-dark" width="100px">title :</td>
			<td><%=qna.getQnaTitle() %></td>
		</tr>
		<tr>
			<td class="table-dark" width="100px">content :</td>
			<td><%=qna.getQnaContent() %></td>
		</tr>
	</table>
	<a href="<%=request.getContextPath() %>/selectQnaList.jsp?currentPage=1">Back</a>
	<!-- Answer 상세 보기 -->
	<table class="table">
		<tr>
			<td>No :</td>
			<td><%=qnaComment.getQnaNo() %></td>
		</tr>
		<tr>
			<td>Comment :</td>
			<td><%=qnaComment.getQnaCommentContent() %></td>
		</tr>
	</table>
	<%
		if(loginMember.getMemberNo() == memberNo){
	%>
			<a href="<%=request.getContextPath() %>/updateQuestionForm.jsp?qnaNo=<%=qna.getQnaNo() %>&qnaContent=<%=qna.getQnaContent() %>">Update</a>
			<a href="<%=request.getContextPath() %>/deleteQuestion.jsp?qnaNo=<%=qna.getQnaNo() %>">Delete</a>
	<%
		}
	%>
</div>	
</body>
</html>