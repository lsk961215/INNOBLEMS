package com.innoblems.dto;

public class UserDTO {
	private int usrSeq;
	private String usrId;
	private String usrPw;
	private String usrNm;
	private String usrBDT;
	private String genderCD;
	private String usrINDT;
	private String statusCD;
	private String rankCD;
	private String gradeCD;
	private String devCD;
	private String usrImg;
	private String usrPn;
	private String usrEm;
	private String usrAd;
	
	public int getUsrSeq() {
		return usrSeq;
	}
	public void setUsrSeq(int usrSeq) {
		this.usrSeq = usrSeq;
	}
	public String getUsrId() {
		return usrId;
	}
	public void setUsrId(String usrId) {
		this.usrId = usrId;
	}
	public String getUsrPw() {
		return usrPw;
	}
	public void setUsrPw(String usrPw) {
		this.usrPw = usrPw;
	}
	public String getUsrNm() {
		return usrNm;
	}
	public void setUsrNm(String usrNm) {
		this.usrNm = usrNm;
	}
	public String getUsrBDT() {
		return usrBDT;
	}
	public void setUsrBDT(String usrBDT) {
		this.usrBDT = usrBDT;
	}
	public String getGenderCD() {
		return genderCD;
	}
	public void setGenderCD(String genderCD) {
		this.genderCD = genderCD;
	}
	public String getUsrINDT() {
		return usrINDT;
	}
	public void setUsrINDT(String usrINDT) {
		this.usrINDT = usrINDT;
	}
	public String getStatusCD() {
		return statusCD;
	}
	public void setStatusCD(String statusCD) {
		this.statusCD = statusCD;
	}
	public String getRankCD() {
		return rankCD;
	}
	public void setRankCD(String rankCD) {
		this.rankCD = rankCD;
	}
	public String getGradeCD() {
		return gradeCD;
	}
	public void setGradeCD(String gradeCD) {
		this.gradeCD = gradeCD;
	}
	public String getDevCD() {
		return devCD;
	}
	public void setDevCD(String devCD) {
		this.devCD = devCD;
	}
	public String getUsrImg() {
		return usrImg;
	}
	public void setUsrImg(String usrImg) {
		this.usrImg = usrImg;
	}
	public String getUsrPn() {
		return usrPn;
	}
	public void setUsrPn(String usrPn) {
		this.usrPn = usrPn;
	}
	public String getUsrEm() {
		return usrEm;
	}
	public void setUsrEm(String usrEm) {
		this.usrEm = usrEm;
	}
	public String getUsrAd() {
		return usrAd;
	}
	public void setUsrAd(String usrAd) {
		this.usrAd = usrAd;
	}
	
	@Override
	public String toString() {
		return "UserDTO [usrSeq=" + usrSeq + ", usrId=" + usrId + ", usrPw=" + usrPw + ", usrNm=" + usrNm + ", usrBDT="
				+ usrBDT + ", genderCD=" + genderCD + ", usrINDT=" + usrINDT + ", statusCD=" + statusCD + ", rankCD="
				+ rankCD + ", gradeCD=" + gradeCD + ", devCD=" + devCD + ", usrImg=" + usrImg + ", usrPn=" + usrPn
				+ ", usrEm=" + usrEm + ", usrAd=" + usrAd + "]";
	}
	
}
