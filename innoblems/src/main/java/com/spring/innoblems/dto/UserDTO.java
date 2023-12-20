package com.spring.innoblems.dto;

public class UserDTO {
	private int usrSeq;
	private String usrId;
	private String usrPw;
	private String usrNm;
	private String usrBDT;
	private String gdCD;
	private String usrINDT;
	private String stCD;
	private String raCD;
	private String grCD;
	private String dvCD;
	private String usrImg;
	private String usrPn;
	private String usrEm;
	private String usrAd;
	private String minDT;
	private String maxDT;
	private String skills;
	
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
	public String getGdCD() {
		return gdCD;
	}
	public void setGdCD(String gdCD) {
		this.gdCD = gdCD;
	}
	public String getUsrINDT() {
		return usrINDT;
	}
	public void setUsrINDT(String usrINDT) {
		this.usrINDT = usrINDT;
	}
	public String getStCD() {
		return stCD;
	}
	public void setStCD(String stCD) {
		this.stCD = stCD;
	}
	public String getRaCD() {
		return raCD;
	}
	public void setRaCD(String raCD) {
		this.raCD = raCD;
	}
	public String getGrCD() {
		return grCD;
	}
	public void setGrCD(String grCD) {
		this.grCD = grCD;
	}
	public String getDvCD() {
		return dvCD;
	}
	public void setDvCD(String dvCD) {
		this.dvCD = dvCD;
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
	public String getMinDT() {
		return minDT;
	}
	public void setMinDT(String minDT) {
		this.minDT = minDT;
	}
	public String getMaxDT() {
		return maxDT;
	}
	public void setMaxDT(String maxDT) {
		this.maxDT = maxDT;
	}
	public String getSkills() {
		return skills;
	}
	public void setSkills(String skills) {
		this.skills = skills;
	}
	
	@Override
	public String toString() {
		return "UserDTO [usrSeq=" + usrSeq + ", usrId=" + usrId + ", usrPw=" + usrPw + ", usrNm=" + usrNm + ", usrBDT="
				+ usrBDT + ", gdCD=" + gdCD + ", usrINDT=" + usrINDT + ", stCD=" + stCD + ", raCD=" + raCD + ", grCD="
				+ grCD + ", dvCD=" + dvCD + ", usrImg=" + usrImg + ", usrPn=" + usrPn + ", usrEm=" + usrEm + ", usrAd="
				+ usrAd + ", minDT=" + minDT + ", maxDT=" + maxDT + ", skills=" + skills + "]";
	}
}
