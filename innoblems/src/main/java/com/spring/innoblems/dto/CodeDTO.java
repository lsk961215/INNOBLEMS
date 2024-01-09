package com.spring.innoblems.dto;

public class CodeDTO {
	private String mstCD;
	private String mstCDNM;
	private String dtCD;
	private String dtCDURL;
	private String dtCDNM;
	public String getMstCD() {
		return mstCD;
	}
	public void setMstCD(String mstCD) {
		this.mstCD = mstCD;
	}
	public String getMstCDNM() {
		return mstCDNM;
	}
	public void setMstCDNM(String mstCDNM) {
		this.mstCDNM = mstCDNM;
	}
	public String getDtCD() {
		return dtCD;
	}
	public void setDtCD(String dtCD) {
		this.dtCD = dtCD;
	}
	public String getDtCDURL() {
		return dtCDURL;
	}
	public void setDtCDURL(String dtCDURL) {
		this.dtCDURL = dtCDURL;
	}
	public String getDtCDNM() {
		return dtCDNM;
	}
	public void setDtCDNM(String dtCDNM) {
		this.dtCDNM = dtCDNM;
	}
	@Override
	public String toString() {
		return "CodeDTO [mstCD=" + mstCD + ", mstCDNM=" + mstCDNM + ", dtCD=" + dtCD + ", dtCDURL=" + dtCDURL
				+ ", dtCDNM=" + dtCDNM + "]";
	}
	
	
}
