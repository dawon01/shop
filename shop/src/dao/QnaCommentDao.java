package dao;

import vo.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import commons.*;

public class QnaCommentDao {
	// [관리자] 답변 삭제
	public void deleteA(int qnaNo) throws ClassNotFoundException, SQLException {
		// 매개변수 값 디버깅 코드
		System.out.println(qnaNo + " <-- QnaCommentDao.deleteA param qnaNo");
		// DB 연동
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리 생성 및 실행
		String sql = "DELETE FROM qna_comment WHERE qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		ResultSet rs = stmt.executeQuery();
		// 디버깅 코드
		System.out.println(stmt + " <-- QnaCommentDao.deleteA stmt");
		System.out.println(rs + " <-- QnaCommentDao.deleteA rs");
		// 자원 해제
		rs.close();
		stmt.close();
		conn.close();
	}
	// [관리자] 답변 수정
	public void updateA(QnaComment qnaComment) throws ClassNotFoundException, SQLException {
		// 매개변수 값 디버깅 코드
		System.out.println(qnaComment.getQnaNo() + " <-- QnaCommentDao.updateA param qnaNo");
		System.out.println(qnaComment.getQnaCommentContent() + " <-- QnaCommentDao.updateA");
		// DB 연동
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리 생성 및 실행
		String sql = "UPDATE qnaComment SET qna_comment_content=? WHERE qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, qnaComment.getQnaCommentContent());
		stmt.setInt(2, qnaComment.getQnaNo());
		ResultSet rs = stmt.executeQuery();
		// 디버깅 코드
		System.out.println(stmt + " <-- QnaCommentDao.updateA stmt");
		System.out.println(rs + " <-- QnaCommentDao.updateA rs");
		// 자원 해제
		rs.close();
		stmt.close();
		conn.close();
	}
	// [관리자] 답변 입력
	public void insertA(QnaComment qnaComment) throws ClassNotFoundException, SQLException {
		// 매개변수 값 디버깅 코드
		System.out.println(qnaComment.getQnaCommentContent() + "<<qnaCommentContent");
		// DB 연동
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리 생성 및 실행
		String sql = "INSERT INTO qna_comment(member_no, qna_comment_content, create_date, update_date) VALUES (?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaComment.getMemberNo());
		stmt.setString(2, qnaComment.getQnaCommentContent());
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
	// [All] QnA 답변 목록
	public QnaComment selectAnswerOne(int qnaNo) throws ClassNotFoundException, SQLException  {
		// 매개변수 값 디버깅 코드
		System.out.println("[Debug] QnaCommentDao.selectAnswerOne qnaNo : " + qnaNo);
		QnaComment qnaComment = null;
		// DB 연동
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리 생성 및 실행
		String sql = "SELECT qna_no qnaNo, qna_comment_content qnaCommentContent FROM qna_comment WHERE qna_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		ResultSet rs = stmt.executeQuery();
		// 디버깅 코드
		System.out.println("[Debug] QnaCommentDao.selectAnswerOne stmt : " + stmt);
		System.out.println("[Debug] QnaCommentDao.selectAnswerOne rs : " + rs);
		// qnaComment 클래스 객체에 값 입력
		if(rs.next()) {
			qnaComment = new QnaComment();
			qnaComment.setQnaNo(rs.getInt("qnaNo"));
			qnaComment.setQnaCommentContent(rs.getString("qnaCommentContent"));
		}
		rs.close();
		stmt.close();
		conn.close();
		
		return qnaComment;
	}
}
