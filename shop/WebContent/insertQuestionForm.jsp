<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	// 로그인 후 문의 사항 입력 가능
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		%>
			<div>로그인 후 사용 가능한 페이지입니다. 로그인 해주세요.</div>
		<%
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	} 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertQuestion.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<div class="container">
	<!-- mainMenu 인클루드(include) 시작 -->
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- mainMenu 인클루드 끝 -->
	<h3>Insert Question</h3>
	<form id="insertQForm"method="post" action="<%=request.getContextPath() %>/insertQuestionAction.jsp">
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
				<td><input type="text" id="qnaTitle" name="qnaTitle"></td>
			</tr>
			<tr>
				<td>Content</td>
				<td><textarea name="qnaContent" id="qnaContent"></textarea></td>
			</tr>
		</table>
		<button type="button" id="insertQbtn">Insert</button>
	</form>
</div>
<script>
	$('#insertQbtn').click(function(){ 
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
		$('#insertQForm').submit();
	});
</script>
</body>
</html>