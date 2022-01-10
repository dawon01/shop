package dao;

import vo.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import commons.*;

public class QnaCommentDao {
	// [������] �亯 ����
	public void deleteA(int qnaNo) throws ClassNotFoundException, SQLException {
		// �Ű����� �� ����� �ڵ�
		System.out.println(qnaNo + " <-- QnaCommentDao.deleteA param qnaNo");
		// DB ����
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// ���� ���� �� ����
		String sql = "DELETE FROM qna_comment WHERE qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		ResultSet rs = stmt.executeQuery();
		// ����� �ڵ�
		System.out.println(stmt + " <-- QnaCommentDao.deleteA stmt");
		System.out.println(rs + " <-- QnaCommentDao.deleteA rs");
		// �ڿ� ����
		rs.close();
		stmt.close();
		conn.close();
	}
	// [������] �亯 ����
	public void updateA(QnaComment qnaComment) throws ClassNotFoundException, SQLException {
		// �Ű����� �� ����� �ڵ�
		System.out.println(qnaComment.getQnaNo() + " <-- QnaCommentDao.updateA param qnaNo");
		System.out.println(qnaComment.getQnaCommentContent() + " <-- QnaCommentDao.updateA");
		// DB ����
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// ���� ���� �� ����
		String sql = "UPDATE qnaComment SET qna_comment_content=? WHERE qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, qnaComment.getQnaCommentContent());
		stmt.setInt(2, qnaComment.getQnaNo());
		ResultSet rs = stmt.executeQuery();
		// ����� �ڵ�
		System.out.println(stmt + " <-- QnaCommentDao.updateA stmt");
		System.out.println(rs + " <-- QnaCommentDao.updateA rs");
		// �ڿ� ����
		rs.close();
		stmt.close();
		conn.close();
	}
	// [������] �亯 �Է�
	public void insertA(QnaComment qnaComment) throws ClassNotFoundException, SQLException {
		// �Ű����� �� ����� �ڵ�
		System.out.println(qnaComment.getQnaCommentContent() + "<<qnaCommentContent");
		// DB ����
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// ���� ���� �� ����
		String sql = "INSERT INTO qna_comment(member_no, qna_comment_content, create_date, update_date) VALUES (?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaComment.getMemberNo());
		stmt.setString(2, qnaComment.getQnaCommentContent());
		// ����� �ڵ�
		System.out.println(stmt + "<<stmt");
		int row = stmt.executeUpdate();
		if (row == 1) {
			System.out.println("�Է¿Ϸ�");
		}
		// �ڿ� ����
		stmt.close();
		conn.close();
		
	}
	// [All] QnA �亯 ���
	public QnaComment selectAnswerOne(int qnaNo) throws ClassNotFoundException, SQLException  {
		// �Ű����� �� ����� �ڵ�
		System.out.println("[Debug] QnaCommentDao.selectAnswerOne qnaNo : " + qnaNo);
		QnaComment qnaComment = null;
		// DB ����
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// ���� ���� �� ����
		String sql = "SELECT qna_no qnaNo, qna_comment_content qnaCommentContent FROM qna_comment WHERE qna_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		ResultSet rs = stmt.executeQuery();
		// ����� �ڵ�
		System.out.println("[Debug] QnaCommentDao.selectAnswerOne stmt : " + stmt);
		System.out.println("[Debug] QnaCommentDao.selectAnswerOne rs : " + rs);
		// qnaComment Ŭ���� ��ü�� �� �Է�
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
