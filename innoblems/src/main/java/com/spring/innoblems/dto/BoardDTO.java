package com.spring.innoblems.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardDTO {
	private int boSeq;
	private int usrSeq;
	private String tpCD;
	private String boTi;
	private String boTXT;
	private String boDT;
	private String boImg;
	private String minDT;
	private String maxDT;
	private String usrNm;
	private String boLob;
}
