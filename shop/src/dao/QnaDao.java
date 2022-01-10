package dao;

import vo.*;
import commons.*;
import java.util.ArrayList;
import java.sql.*;

public class QnaDao {
	// [회원] Q 삭제 메서드
	public void deleteQ(int qnaNo) throws ClassNotFoundException, SQLException {
		// 매개변수 값 디버깅 코드
		System.out.println(qnaNo + " <-- QnaDao.deleteQ param qnaNo");
		// DB 연동
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리 생성 및 실행
		String sql = "DELETE FROM qna WHERE qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		ResultSet rs = stmt.executeQuery();
		// 디버깅 코드
		System.out.println(stmt + " <-- QnaDao.deleteQ stmt");
		System.out.println(rs + " <-- QnaDao.deleteQ rs");
		// 자원 해제
		rs.close();
		stmt.close();
		conn.close();
	}
	// [회원] Q 수정 메서드
	public void updateQ(Qna Q) throws ClassNotFoundException, SQLException {
		// 매개변수 값 디버깅 코드
		System.out.println(Q.getQnaNo() + " <-- QnaDao.updateQ param qnaNo");
		System.out.println(Q.getQnaContent() + " <-- QnaDao.updateQ");
		System.out.println(Q.getQnaCategory() + "<-- QnaDao.updateQ");
		System.out.println(Q.getQnaSecret() + "<-- QnaDao.updateQ");
		System.out.println(Q.getQnaTitle() + "<-- QnaDao.updateQ");
		// DB 연동
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리 생성 및 실행
		String sql = "UPDATE qna SET qna_category=? qna_title=? qna_content=? qna_secret=? WHERE qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, Q.getQnaCategory());
		stmt.setString(2, Q.getQnaTitle());
		stmt.setString(3, Q.getQnaContent());
		stmt.setString(4, Q.getQnaSecret());
		stmt.setInt(5, Q.getQnaNo());
		ResultSet rs = stmt.executeQuery();
		// 디버깅 코드
		System.out.println(stmt + " <-- QnaCommentDao.updateA stmt");
		System.out.println(rs + " <-- QnaCommentDao.updateA rs");
		// 자원 해제
		rs.close();
		stmt.close();
		conn.close();
	}
	// [회원] Q 입력 메서드
		public void insertQ(Qna Q) throws ClassNotFoundException, SQLException {
			// 매개변수 값 디버깅 코드
			System.out.println(Q.getQnaCategory() + "<<qnaCategory");
			System.out.println(Q.getQnaSecret() + "<<qnaSecret");
			System.out.println(Q.getQnaTitle() + "<<qnaTitle");
			System.out.println(Q.getQnaContent() + "<<qnaContent");
			// DB 연동
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			// 쿼리 생성 및 실행
			String sql = "INSERT INTO qna(member_no, qna_category, qna_secret, qna_title, qna_content, create_date, update_date) VALUES (?, ?, ?, ?, ?, NOW(), NOW())";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, Q.getMemberNo());
			stmt.setString(2, Q.getQnaCategory());
			stmt.setString(3, Q.getQnaSecret());
			stmt.setString(4, Q.getQnaTitle());
			stmt.setString(5, Q.getQnaContent());
			// 디버깅 코드
			System.out.println(stmt + "<<stmt");
			int row = stmt.executeUpdate();
			if (row == 1) {
				System.out.println("입력완료");
			}
			// 자원 해제
			stmt.close();
			conn.close();
		}
	//[관리자] 답변 없는 Q 목록 출력
	public ArrayList<Qna> selectNoAnswerQuestionList() throws ClassNotFoundException, SQLException{
		ArrayList<Qna> list = new ArrayList<Qna>();
		// DB 연동
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT q.*, qc.* FROM qna q LEFT JOIN qna_comment qc ON q.qna_no=qc.qna_no WHERE qc.qna_no IS NULL";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		System.out.println("[Debug] QnaDao.selectNoAnswerQuestionList stmt : " + stmt);
		System.out.println("[Debug] QnaDao.selectNoAnswerQuestionList rs : " + rs);
		
		while (rs.next()) {
			Qna q = new Qna();
			q.setQnaNo(rs.getInt("q.qna_no"));
			q.setMemberNo(rs.getInt("q.member_no"));
			q.setQnaTitle(rs.getString("q.qna_title"));
			q.setQnaSecret(rs.getString("q.qna_secret"));
			list.add(q);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	// [All] Q&A 상세 보기
	public Qna selectQuestionOne(int qnaNo) throws ClassNotFoundException, SQLException {
		// 매개변수 값 디버깅 코드
		System.out.println("[Debug] QnaDao.selectQuestionOne qnaNo : " + qnaNo);
		Qna qna = null;
		// DB 연동
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리 생성 및 실행
		String sql = "SELECT qna_no qnaNo, qna_category qnaCategory, qna_title qnaTitle, qna_content qnaContent FROM qna WHERE qna_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		ResultSet rs = stmt.executeQuery();
		
		System.out.println("[Debug] QnaDao.selectQuestionOne stmt : " + stmt);
		System.out.println("[Debug] QnaDao.selectQuestionOne rs : " + rs);
		
		if(rs.next()) {
			qna = new Qna();
			qna.setQnaNo(rs.getInt("qnaNo"));
			qna.setQnaCategory(rs.getString("qnaCategory"));
			qna.setQnaTitle(rs.getString("qnaTitle"));
			qna.setQnaContent(rs.getString("qnaContent"));
		}
		rs.close();
		stmt.close();
		conn.close();

		return qna;
	}
	// [관리자] 전체 Q&A 목록
	public ArrayList<Qna> selectQnaListByAdmin(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException{
		// 배열 list 생성
		ArrayList<Qna> list = new ArrayList<Qna>();
		// DB 연동
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리 생성 및 실행
		String sql = "SELECT qna_no qnaNo, qna_category qnaCategory, qna_title qnaTitle, qna_secret qnaSecret,qna_answer qnaAnswer FROM qna ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
			
		System.out.println("[Debug] QnaDao.selectQnaListByAdmin stmt : " + stmt);
		System.out.println("[Debug] QnaDao.selectQnaListByAdmin rs : " + rs);

		while (rs.next()) {
			Qna q = new Qna();
			q.setQnaNo(rs.getInt("qnaNo"));
			q.setQnaCategory(rs.getString("qnaCategory"));
			q.setQnaTitle(rs.getString("qnaTitle"));
			q.setQnaSecret(rs.getString("qnaSecret"));
			q.setQnaAnswer(rs.getString("qnaAnswer"));
			list.add(q);
		}

		rs.close();
		stmt.close();
		conn.close();
			
		return list;
	}
	// [All] 전체 Q&A 목록
	public ArrayList<Qna> selectQnaList(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException{
		// 배열 list 생성
		ArrayList<Qna> list = new ArrayList<Qna>();
		// DB 연동
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리 생성 및 실행
		String sql = "SELECT qna_no qnaNo, qna_category qnaCategory, qna_title qnaTitle, qna_secret qnaSecret, qna_answer qnaAnswer FROM qna ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		System.out.println("[Debug] QnaDao.selectQnaList stmt : " + stmt);
		System.out.println("[Debug] QnaDao.selectQnaList rs : " + rs);


		while (rs.next()) {
			Qna q = new Qna();
	
			q.setQnaNo(rs.getInt("qnaNo"));
			q.setQnaCategory(rs.getString("qnaCategory"));
			q.setQnaTitle(rs.getString("qnaTitle"));
			q.setQnaSecret(rs.getString("qnaSecret"));
			q.setQnaAnswer(rs.getString("qnaAnswer"));
			list.add(q);
		}

		rs.close();
		stmt.close();
		conn.close();
		
		
		return list;
	}
}
