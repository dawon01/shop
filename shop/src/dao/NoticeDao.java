package dao;

import vo.*;
import java.util.*;
import java.sql.*;
import commons.*;

public class NoticeDao {
	// [관리자] 공지사항 수정
	public void updateNoticeByAdmin(Notice notice) throws ClassNotFoundException, SQLException {
		// debug
		System.out.println(notice.getNoticeNo() + " <-- NoticeDao.updateNoticeByAdmin param noticeNo");
		System.out.println(notice.getNoticeTitle() + " <-- NoticeDao.updateNoticeByAdmin param noticeTitle");
		System.out.println(notice.getNoticeContent() + " <-- NoticeDao.updateNoticeByAdmin param noticeContent");
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();

		String sql = "UPDATE notice SET notice_title=?, notice_content=? WHERE notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setInt(3, notice.getNoticeNo());
		ResultSet rs = stmt.executeQuery();
		// debug
		System.out.println(stmt + " <-- NoticeDao.updateNoticByAdmin stmt");
		System.out.println(rs + " <-- NoticeDao.updateNoticeByAdmin rs");

		rs.close();
		stmt.close();
		conn.close();
	}
	// [관리자] 공지사항 삭제
	public void deleteNoticeByAdmin(int noticeNo) throws ClassNotFoundException, SQLException {
		// debug
		System.out.println(noticeNo + " <-- NoticeDao.deleteNoticeByAdmin param noticeNo");

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();

		String sql = "DELETE FROM notice WHERE notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		ResultSet rs = stmt.executeQuery();
		// debug
		System.out.println(stmt + " <-- NoticeDao.deleteNoticeByAdmin stmt");
		System.out.println(rs + " <-- NoticeDao.deleteNoticeByAdmin rs");

		rs.close();
		stmt.close();
		conn.close();
	}
	// [All] 최근 공지사항 5개 출력
	public ArrayList<Notice> selectNewNoticeList() throws ClassNotFoundException, SQLException{
		ArrayList<Notice> list = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle FROM notice ORDER BY create_date DESC LIMIT 0, 5";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeTitle(rs.getString("noticeTitle"));
			list.add(n);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	//[All] 공지사항 상세 보기
	public Notice selectNoticeOne(int noticeNo) throws ClassNotFoundException, SQLException {
		System.out.println(noticeNo);
		Notice notice = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent FROM notice WHERE notice_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			notice = new Notice();
			notice.setNoticeNo(rs.getInt("noticeNo"));
			notice.setNoticeTitle(rs.getString("noticeTitle"));
			notice.setNoticeContent(rs.getString("noticeContent"));
		}
		rs.close();
		stmt.close();
		conn.close();
		
		return notice;
	}
	// [ALL] 공지사항 No,title 리스트
	public ArrayList<Notice> selectNoticeList(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException{
		ArrayList <Notice> list = new ArrayList<Notice>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle FROM notice ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		System.out.println("[Debug] NoticeDao.selectNoticeList stmt : " + stmt);
		System.out.println("[Debug] NoticeDao.selectNoticeList rs : " + rs);


		while (rs.next()) {
			Notice n = new Notice();
	
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeTitle(rs.getString("noticeTitle"));
			
			list.add(n);
		}

		rs.close();
		stmt.close();
		conn.close();

		return list;
	}
	// [All] notice 마지막 페이지 출력 메서드
	public int selectNoticeLastPage(int rowPerPage, int noticeNo) throws ClassNotFoundException, SQLException {
		int lastPage = 0;
		// DB 연동
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리 생성 및 실행
		String sql = "SELECT COUNT(*) from notice";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		 
		int totalRowCount = 0;

		System.out.println("[Debug] selectNoticeLastPage stmt : " + stmt);
		System.out.println("[Debug] selectNoticeLastPage rs : " + rs);

		if (rs.next()) {
			totalRowCount = rs.getInt("COUNT(*)");
		}
		lastPage = totalRowCount / rowPerPage;
		if (totalRowCount % rowPerPage != 0) {
			lastPage++;
		}

		rs.close();
		stmt.close();
		conn.close();

		return lastPage;
	}
}
