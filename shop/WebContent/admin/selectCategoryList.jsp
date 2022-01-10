<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%	
	//한글인코딩
	request.setCharacterEncoding("utf-8");
	//사용자(일반 회원)들 리스트는 관리자만 출입
	//방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	//로그인 멤버값이 없거나 memberLevel이 1미만(일반 사용자)일때는 접근 불가. 순서를 바꾸면안됨(바꾸면 null포인트 인셉션이 일어남).
	if(loginMember==null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>selectCategoryList.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<!-- 관리자 메뉴 인클루드(include)시작 ,페이지 형태만 인클루드 하는 것이 좋음(코드 형태는 비추천).-->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- 관리자 메뉴 인클루드 끝 -->
	<br>
	<div class="jumbotron">
		<h1>Ebook Category</h1>
		<a href="insertCategoryForm.jsp">Insert</a>
	</div>
	<br>
	<table class="table table-dark table-striped">
		<thead>
			<tr>
			 	<th>categoryName</th>
			 	<th>categoryState</th>
			 	<th>updateDate</th>
			 	<th>createDate</th>
			 	<th>selectState</th>
			</tr>
		</thead>
		<tbody>
			<%
			for(Category c : categoryList){
			%>
			<tr>
				<td><%=c.getCategoryName()%></td>
				<td><%=c.getCategoryState()%></td>
				<td><%=c.getUpdateDate()%></td>
				<td><%=c.getCreateDate()%></td>
				<td>
					<!-- 사용상태 수정 -->
					<form id="updateStateForm" method="post" action="<%=request.getContextPath()%>/admin/updateCategoryStateAction.jsp?categoryName=<%=c.getCategoryName()%>">
						<select id="selectCategory" name="categoryState">
							<%
								if(c.getCategoryState().equals("Y")) {
							%>
									<option value="Y" selected="selected">Y</option>
									<option value="N">N</option>
							<%
								} else {
							%>
									<option value="Y">Y</option>
									<option value="N" selected="selected">N</option>
							<%		
								}
							%>
						</select>
						<button type="button" id="updateState">Update</button>
					</form>
				</td>
			<%
			}
			%>
		</tbody>
	</table>
</div>
<script>
	$('#updateState').click(function(){
		if($('#selectCategory option : selected').val() == '') {
				alert('카테고리 사용여부를 입력하세요');
				return;
			}
		$('#updateStateForm').submit();
	})
</script>
</body>
</html>