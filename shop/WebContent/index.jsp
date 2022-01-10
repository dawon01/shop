<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
		// 페이징
		int currentPage = 1;
		if (request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		String ebookCategory = "";
		if(request.getParameter("ebookCategory") != null){
			ebookCategory = request.getParameter("ebookCategory");
		}
		final int ROW_PER_PAGE = 10; // rowPerPage변수 10으로 초기화되면 끝까지 10을 써야 한다. --> 상수
		int beginRow = (currentPage - 1) * ROW_PER_PAGE;
	
		// 전자책 전체 목록
		EbookDao ebookDao = new EbookDao();
		ArrayList<Ebook> ebookList = ebookDao.selectEbookList(beginRow, ROW_PER_PAGE);
		
		// 인기 목록 5개(많이 주문된 5개의 ebook)
		ArrayList<Ebook> popularEbookList = ebookDao.selectPopularEbookList();
		
		// 신상품 목록 5개
		ArrayList<Ebook> newEbookList = ebookDao.selectNewEbookList();
		
		NoticeDao noticeDao = new NoticeDao();
		// 최근 공지사항 5개
		ArrayList<Notice> newNoticeList = noticeDao.selectNewNoticeList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index.jsp</title>
<link  rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<div class = "container">
	<!-- mainMenu 인클루드(include) 시작 -->
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- mainMenu 인클루드 끝 -->
	<div>
	<h4>최근 공지사항</h4>
	<table class="table table-hover">
		<thead class="thead-dark">
			<th>no</th>
			<th>title</th>
		</thead>
		<tbody>
			<%
				for(Notice n : newNoticeList){
			%>
					<tr>						
						<td><%=n.getNoticeNo()%></td>
						<td><a href="<%=request.getContextPath()%>/selectNoticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle()%></a></td>
					</tr>	
			<%	
				}
			%>
		</tbody>
	</table>
	
	<h4>Qna List</h4>
	<table class = "table">
		
	</table>
	<!-- 상품 목록 -->
	<h4>신상품 목록</h4>
	<table class="table table-borderless">
		<tr>
		<%
			for(Ebook e : newEbookList){
		%>
				<td>
					<div>
						<a href=""><img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" width="200" height="200"></a>
					</div>
					<div><a href=""><%=e.getEbookTitle()%></a></div>
					<div>₩ <%=e.getEbookPrice()%></div>
				</td>
		<%
			}
		%>
		</tr>
	</table>
	
	<h4>인기 상품 목록</h4>
	<table class="table table-borderless">
		<tr>
			<%
				for(Ebook e: popularEbookList) {
			%>
					<td>
						<div>
							<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>">
								<img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" width="200" height="200">
							</a>
						</div>
						<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle()%></a></div>
						<div>₩ <%=e.getEbookPrice()%></div>
					</td>
			<%
				}
			%>
		</tr>
	</table>
	
	<h4>전체 상품 목록</h4>
	<table class="table table-borderless">
		<tr>
			<%
				int i = 0;
				for(Ebook e : ebookList) {
			%>	
					<td>
						<div>
							<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" width="200" height="200"></a>
						</div>
						<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle()%></a></div>
						<div>₩ <%=e.getEbookPrice()%></div>
					</td>	
			<%
					i+=1; // i=i+1; i++; for문 끝날때마다 i는 1씩 증가
					if(i%5 == 0) {
			%>
						</tr><tr><!-- 줄바꿈 -->
			<%			
					}
				}
			%>
		</tr>
	</table>
</div>
	<!-- 하단 네비게이션 바 -->
		<div>
			<a class="btn btn-link"
				href="<%=request.getContextPath()%>/index.jsp?currentPage=1">처음으로</a>
			<%
			if (currentPage != 1) {
			%>
			<a class="btn btn-link"
				href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=currentPage - 1%>">이전</a>
			<%
			}

			int totalCount = ebookDao.totalEbookCount(ebookCategory);
			int lastPage = totalCount / ROW_PER_PAGE;

			int displayPage = 10;

			int startPage = ((currentPage - 1) / displayPage) * displayPage + 1;
			int endPage = startPage + displayPage - 1;

			for(i = startPage; i <= endPage; i++){
				if (i < lastPage) {
				%>
					<a href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=i%>"><%=i%></a>
				<%
				} else if (endPage > lastPage) {
				%>
					<a href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=i%>"><%=i%></a>
				<%
				}
				
				if (i == lastPage) {
					break;
				}
			}
			if (currentPage != lastPage) {
			%>
				<a href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=startPage + displayPage%>">다음</a>
			<%
			}
			%>
			<a href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=lastPage%>">끝으로</a>
		</div>
	<div>copyright goodee GDJ40</div>
</div>
</body>
</html>