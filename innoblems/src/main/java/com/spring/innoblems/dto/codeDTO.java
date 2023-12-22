package com.spring.innoblems.dto;

public class codeDTO {
	private String mstCD;
	private String mstNM;
	private String dtCD;
	private String dtNM;
	
	public String getMstCD() {
		return mstCD;
	}
	public void setMstCD(String mstCD) {
		this.mstCD = mstCD;
	}
	public String getMstNM() {
		return mstNM;
	}
	public void setMstNM(String mstNM) {
		this.mstNM = mstNM;
	}
	public String getDtCD() {
		return dtCD;
	}
	public void setDtCD(String dtCD) {
		this.dtCD = dtCD;
	}
	public String getDtNM() {
		return dtNM;
	}
	public void setDtNM(String dtNM) {
		this.dtNM = dtNM;
	}
	
	@Override
	public String toString() {
		return "codeDTO [mstCD=" + mstCD + ", mstNM=" + mstNM + ", dtCD=" + dtCD + ", dtNM=" + dtNM + "]";
	}
}
