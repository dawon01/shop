<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 인코딩 utf-8로 설정
	request.setCharacterEncoding("utf-8");
	// 로그인 후 사용가능한 페이지
	Member loginMember = (Member) session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
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
<title>Qna ReadMore</title>
<link  rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<h3>Qna 상세보기</h3>
	<br>
	<%
		QnaDao qnaDao = new QnaDao();
		Qna qna = qnaDao.selectQuestionOne(qnaNo);
		QnaCommentDao qnaCommentDao = new QnaCommentDao();
		QnaComment qnaComment = qnaCommentDao.selectAnswerOne(qnaNo);
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
	<!-- 관리자 답변 수정 및 삭제 버튼 -->
	<%
		if(loginMember.getMemberLevel() > 0){
	%>
			<a href="<%=request.getContextPath() %>/admin/updateAnswerForm.jsp?qnaNo=<%=qnaComment.getQnaNo() %>&qnaCommentContent=<%=qnaComment.getQnaCommentContent() %>">Update</a>
			<a href="<%=request.getContextPath() %>/admin/deleteAnswer.jsp?qnaNo=<%=qnaComment.getQnaNo() %>">Delete</a>
	<%
		}
	%>
</div>
</body>
</html>