<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	//인코딩 utf-8로 설정
	request.setCharacterEncoding("utf-8");

	Qna qna = new Qna();
	qna.setQnaNo(Integer.parseInt(request.getParameter("qnaNo")));
	// 디버깅 코드
	System.out.println("qnaNo ->" + qna.getQnaNo());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateQuestionForm.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<div class="container">
	<form id="updateQ" action="<%=request.getContextPath() %>/updateQuestionAction.jsp">
		<h1>Update Question</h1>
		<table class="table table-striped">
			<tr>
				<td>Category</td>
				<td>
					<input type="radio" name="qnaCategory" name="qnaCategory" value="전자책관련">전자책
					<input type="radio" name="qnaCategory" name="qnaCategory" value="개인정보관련">개인정보
					<input type="radio" name="qnaCategory" name="qnaCategory" value="기타">기타
				</td>
			</tr>
			<tr>
				<td>Secret</td>
				<td>
					<input type="checkbox" name="qnaSecret" name="qnaSecret" value="Y">비밀글
					<input type="checkbox" name="qnaSecret" name="qnaSecret" value="N">공개글
				</td>
			</tr>
			<tr>
				<td>Title</td>
				<td><input type="text" id="qnaTitle" name="qnaTitle" value="<%=qna.getQnaTitle() %>"></td>
			</tr>
			<tr>
				<td>Content</td>
				<td><textarea name="qnaContent" id="qnaContent" value="<%=qna.getQnaContent() %>"></textarea></td>
			</tr>
		</table>
		<div><input type = "text" id="qnaNo" name="qnaNo" hidden="hidden" value = "<%=qna.getQnaNo()%>"></div>
		<button id="updateQbtn" type="button">Update Q</button>
	</form>
	<Script>
		$('#updateQbtn').click(function(){
			if($('input[name = "qnaCategory"] : checked').val() == '') {
				alert('카테고리를 선택해주세요.');
				return;
			}
			if($('input[name = "qnaSecret"] : checked').val() == '') {
				alert('비밀글 여부를 선택해주세요.');
				return;
			}
			if($('#qnaTitle').val() == ''){
				alert('제목을 입력해주세요.');
				return;
			}
			if($('#qnaContent').val() == ''){
				alert('내용을 입력해주세요.');
				return;
			}
			$('#updateQ').submit();
		});
	</Script>
</div>
</body>
</html>