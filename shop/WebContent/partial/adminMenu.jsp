<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="container-fluid">
	<nav class="navbar navbar-expand-md bg-dark navbar-dark">
		<a class="navbar-brand" href="<%=request.getContextPath() %>/index.jsp?currentPage=1">Home</a>
		<div class="collapse navbar-collapse" id="collapsibleNavbar">
			<ul class="navbar-nav">
				<!--  회원 관리(Member Management) : 목록, 수정(회원 등급, 회원 비밀번호), 강제탈퇴 -->
				<li class="nav-item">
					<a class="nav-link" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp">Member</a>
				</li>
				<!-- 전자책 카테고리 관리(Book Category Management) : 목록, 추가, 사용여부 수정 -->
				<li class="nav-item">
					<a class="nav-link" href="<%=request.getContextPath()%>/admin/selectCategoryList.jsp">EBook Category</a>
				</li>
				<!-- 전자책 관리(Book Management) : 목록, 추가, 수정, 삭제 -->
				<li class="nav-item">
					<a class="nav-link" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp">EBook</a>
				</li>
				<!--  -->
				<li class="nav-item">
					<a class="nav-link" href="<%=request.getContextPath()%>/admin/selectOrderList.jsp">Order</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="<%=request.getContextPath()%>/admin/selectCommentList.jsp">Review</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="<%=request.getContextPath()%>/admin/selectNoticeList.jsp">Notice</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="<%=request.getContextPath()%>/admin/selectQnaList.jsp">Q&A</a>
				</li>
			</ul>
		</div>
	</nav>
</div>