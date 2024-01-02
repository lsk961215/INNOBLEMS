package com.spring.innoblems.dto;

public class ProjectDTO {
	private int prjSeq;
	private String cusCD;
	private String prjNm;
	private String prjSTDT;
	private String prjEDDT;
	private String prjNote;
	private String minSTDT;
	private String maxSTDT;
	private String minEDDT;
	private String maxEDDT;
	private String skills;
	
	public int getPrjSeq() {
		return prjSeq;
	}
	public void setPrjSeq(int prjSeq) {
		this.prjSeq = prjSeq;
	}
	public String getCusCD() {
		return cusCD;
	}
	public void setCusCD(String cusCD) {
		this.cusCD = cusCD;
	}
	public String getPrjNm() {
		return prjNm;
	}
	public void setPrjNm(String prjNm) {
		this.prjNm = prjNm;
	}
	public String getPrjSTDT() {
		return prjSTDT;
	}
	public void setPrjSTDT(String prjSTDT) {
		this.prjSTDT = prjSTDT;
	}
	public String getPrjEDDT() {
		return prjEDDT;
	}
	public void setPrjEDDT(String prjEDDT) {
		this.prjEDDT = prjEDDT;
	}
	public String getPrjNote() {
		return prjNote;
	}
	public void setPrjNote(String prjNote) {
		this.prjNote = prjNote;
	}
	public String getMinSTDT() {
		return minSTDT;
	}
	public void setMinSTDT(String minSTDT) {
		this.minSTDT = minSTDT;
	}
	public String getMaxSTDT() {
		return maxSTDT;
	}
	public void setMaxSTDT(String maxSTDT) {
		this.maxSTDT = maxSTDT;
	}
	public String getMinEDDT() {
		return minEDDT;
	}
	public void setMinEDDT(String minEDDT) {
		this.minEDDT = minEDDT;
	}
	public String getMaxEDDT() {
		return maxEDDT;
	}
	public void setMaxEDDT(String maxEDDT) {
		this.maxEDDT = maxEDDT;
	}
	public String getSkills() {
		return skills;
	}
	public void setSkills(String skills) {
		this.skills = skills;
	}
	
	@Override
	public String toString() {
		return "ProjectDTO [prjSeq=" + prjSeq + ", cusCD=" + cusCD + ", prjNm=" + prjNm + ", prjSTDT=" + prjSTDT
				+ ", prjEDDT=" + prjEDDT + ", prjNote=" + prjNote + ", minSTDT=" + minSTDT + ", maxSTDT=" + maxSTDT
				+ ", minEDDT=" + minEDDT + ", maxEDDT=" + maxEDDT + ", skills=" + skills + "]";
	}
}
