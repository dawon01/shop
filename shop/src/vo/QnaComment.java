package vo;

public class QnaComment {
	private int qnaNo;
	private int memberNo;
	private String qnaCommentContetent;
	private String createDate;
	private String updateDate;
	
	public int getQnaNo() {
		return qnaNo;
	}
	public void setQnaNo(int qnaNo) {
		this.qnaNo = qnaNo;
	}
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public String getQnaCommentContent() {
		return qnaCommentContetent;
	}
	public void setQnaCommentContent(String qnaCommentContetent) {
		this.qnaCommentContetent = qnaCommentContetent;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	@Override
	public String toString() {
		return "QnaComment [qnaNo=" + qnaNo + ", memberNo=" + memberNo + ", qnaCommentContetent=" + qnaCommentContetent
				+ ", createDate=" + createDate + ", updateDate=" + updateDate + "]";
	}
	
}
