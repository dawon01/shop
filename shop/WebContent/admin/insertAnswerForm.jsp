<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// 인코딩 utf-8로 설정
	request.setCharacterEncoding("utf-8");
	// 로그인 후에 사용가능한 페이지(관리자만)
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertAnswerForm.jsp</title>
</head>
<body>
<div class="container">
	<h4>Answer</h4>
	<form id="insertAForm" method="post" action="<%=request.getContextPath() %>/admin/insertAnswerAction.jsp">
		<table class="table">
			<tr>
				<td>No :</td>
				<td><input type="text" id="qnaNo" name="qnaNo" readonly="readonly"></td>
			</tr>
			<tr>
				<td>Comment</td>
				<td><textarea id="qnaCommentContent" name="qnaCommentContent"></textarea></td>
			</tr>
		</table>
		<button id="insertAbtn" type="button">insert</button>
	</form>
</div>
<script>
	$('#insertAbtn').click(function(){
		if($('#qnaCommentContent').val() == ''){
			alert('내용을 입력해주세요.');
			return;
		}
		$('#insertAForm').submit();
	});
</script>
</body>
</html>