<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateAnswerForm.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<%
	// 인코딩 utf-8로 설정
	request.setCharacterEncoding("utf-8");

	QnaComment qnaComment = new QnaComment();
	qnaComment.setQnaNo(Integer.parseInt(request.getParameter("qnaNo")));
	// 디버깅 코드
	System.out.println("qnaNo ->" + qnaComment.getQnaNo());
	%>
	<form id="updateA" action="<%=request.getContextPath() %>/admin/updateAnswerAction.jsp">
		<h1>Update Answer</h1>
		<div>Comment : </div>
		<div><textarea id="qnaCommentContent"></textarea></div>
		<div><input type = "text" id="qnaNo" name="qnaNo" hidden="hidden" value = "<%=qnaComment.getQnaNo()%>"></div>
		<button id="updateAbtn" type="button">Update A</button>
	</form>
	<Script>
		$('#updateAbtn').click(function(){
			if($('#qnaComment').val() == ''){
				alert('내용을 입력하세요');
				return;
			}
			$('#updateA').submit();
		});
	</Script>
</body>
</html>