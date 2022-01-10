<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<div class="container">
		<h1>회원가입</h1>
		<%
			String memberIdCheck = "";
			if(request.getParameter("memberIdCheck") != null){
				request.getParameter("memberIdCheck");
			}
		%>
		<!-- 사용가능한 회원Id 확인 폼 -->
		<form action="<%=request.getContextPath() %>/selectMemberIdCheckAction.jsp" method="post">
			<div>
				 Id : 
				 <input type="text" name="memberIdCheck">
			</div>
			<button type="submit">Check Operating account</button>
		</form>
		<!-- 회원가입 폼 -->
		<form id="joinForm" action="<%=request.getContextPath() %>/insertMemberAction.jsp" method="post">
			<table class="table">
				<tr>
					<td>Id : </td>
					<td><input type="text" class="form-control form-control-lg" id="memberId" name="memberId" readonly="readonly" value="<%=memberIdCheck %>"></td>
				</tr>
				<tr>
					<td>Pw : </td>
					<td><input type="password" class="form-control form-control-lg" id="memberPw" name="memberPw"></td>
				</tr>
				<tr>
					<td>Name : </td>
					<td><input type="text" class="form-control form-control-lg" id="memberName" name="memberName"></td>
				</tr>
				<tr>
					<td>Age : </td>
					<td><input type="text" class="form-control form-control-lg" id="memberAge" name="memberAge"></td>
				</tr>
				<tr>
					<td>Gender : </td>
					<td>
						<input type="radio" class="memberGender" name="memberGender" value="남">남
						<input type="radio" class="memberGender" name="memberGender" value="여">여
					</td>
				</tr>
			</table>
			<button type="button" id="btn" class="btn btn-primary">입력</button>
		</form>
	</div>
	<script>
		$('#btn').click(function(){
			if($('#memberId').val() == '') {
				alert('memberId를 입력하세요');
				return;
			}
			if($('#memberPw').val() == '') {
				alert('memberPw를 입력하세요');
				return;
			}
			if($('#memberName').val() == '') {
				alert('memberName를 입력하세요');
				return;
			}
			if($('#memberAge').val() == '') {
				alert('memberAge를 입력하세요');
				return;
			}
			let memberGender = $('.memberGender:checked'); // . 클래스속성으로 부르면 리턴값은 배열
			if(memberGender.length == 0) {
				alert('memberGender를 선택하세요');
				return;
			}
			
			$('#joinForm').submit();
		});
	
		
	</script>
</body>
</html>