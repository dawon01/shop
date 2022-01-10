<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>

<%
	// 인코딩
	request.setCharacterEncoding("utf-8");

	// 방어코드
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
<title>insertNotice.jsp</title>
<link  rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

</head>
<body>
<div>
	<h1>공지사항 작성</h1>
	<form id="noticeForm" method="post" action="<%=request.getContextPath() %>/admin/insertNoticeAction.jsp">
		<table>
			<tr>
				<td>title</td>
				<td><input type="text" id="noticeTitle" name="noticeTitle"></td>
			</tr>
			<tr>
				<td>content</td>
				<td><textarea  id="noticeContent" name = "noticeContent" rows="5"></textarea></td>
			</tr>
		</table>
		<button type="button" id="insertNotice">Insert</button>
	</form>

</div>
<script>
	$('#insertNotice').click(function(){
		if($('#noticeTitle').val() == '') {
			alert('title을 입력하세요');
			return;
		}
		if($('#noticeContent').val() == '') {
			alert('content를 입력하세요');
			return;
		}
		
		$('#noticeForm').submit();
	});
</script>
</body>
</html>