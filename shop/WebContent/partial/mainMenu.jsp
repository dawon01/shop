<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<div class="container">	
<!-- 로그인 작업 -->
	<nav class="navbar navbar-expand-md bg-dark navbar-dark">
		<a class="navbar-brand" href="<%=request.getContextPath() %>/index.jsp">Home</a>
		<div class="collapse navbar-collapse" id="collapsibleNavbar">
			<ul class="navbar-nav ">
			<%
				if(session.getAttribute("loginMember") == null) {
			%>
						
					<li class="nav-item">
						<a class="nav-link" href="<%=request.getContextPath() %>/loginForm.jsp" class="btn">로그인</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="<%=request.getContextPath() %>/insertMemberForm.jsp" class="btn">회원가입</a>
					</li>
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="<%=request.getContextPath() %>/index.jsp" id="navbardrop" data-toggle="dropdown">
							Menu
						</a>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="<%=request.getContextPath() %>/cartList.jsp">cart</a>
							<a class="dropdown-item" href="#">menu4</a>
							<a class="dropdown-item" href="#">menu5</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="<%=request.getContextPath() %>/selectNoticeList.jsp">notice</a>
							<a class="dropdown-item" href="<%=request.getContextPath() %>/selectQnaList.jsp">Q&A</a>        
							<a class="dropdown-item" href="#">another menu</a>
						</div>
					</li>
					</ul>
					</div>
					</nav>
					<br>
					<div class="jumbotron">
						<h1>비블리아 고서당</h1>
						<p class="small">고객님 반갑습니다.</p>
					</div>
				<%		
					} else {
						Member loginMember = (Member)session.getAttribute("loginMember");
				%>
					<!-- 로그인 -->
					<li class="nav-item">
						<a class="nav-link" href="<%=request.getContextPath()%>/logout.jsp">Log-Out</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="<%=request.getContextPath()%>/myPageForm.jsp">My Page</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="<%=request.getContextPath()%>/selectOrderListByMember.jsp">Order List</a>
					</li>
					<!-- 관리자 페이지로 가는 링크 -->
				<%
						if(loginMember.getMemberLevel() > 0) {
				%>
							<li class="nav-item">
								<a class="nav-link" href="<%=request.getContextPath()%>/admin/adminIndex.jsp">Admin Page</a>
							</li>
				<%
						}
				%>
									<li class="nav-item dropdown">
								      <a class="nav-link dropdown-toggle" href="<%=request.getContextPath() %>/index.jsp" id="navbardrop" data-toggle="dropdown">
								        Menu
								      </a>
								      <div class="dropdown-menu">
								        <a class="dropdown-item" href="#">내 게시글</a>
								        <a class="dropdown-item" href="<%=request.getContextPath() %>/cartList.jsp">장바구니</a>
								        <a class="dropdown-item" href="#">쿠폰 목록</a>
								        <a class="dropdown-item" href="#">menu4</a>
								        <a class="dropdown-item" href="#">menu5</a>
								        <div class="dropdown-divider"></div>
								        <a class="dropdown-item" href="<%=request.getContextPath() %>/selectNoticeList.jsp">Notice</a>
								        <a class="dropdown-item" href="<%=request.getContextPath() %>/selectQnaList.jsp">Q&A</a>
								        <a class="dropdown-item" href="#">회원 탈퇴</a>
								      </div>
								    </li>
								    
								    <li class="nav-item">
								    	<p class="nav-link text-light"><%=loginMember.getMemberId()%>님 로그인 중</p>
								    </li>
								</ul>
							</div>
						</nav>
						<br>
						<div class="jumbotron">
							<h1>비블리아 고서당</h1>
							<p><%=loginMember.getMemberId()%>님 반갑습니다.</p>
						</div>
				<%
					}
				%>
	</div>
