package com.spring.innoblems.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
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
	private String currentPage;
	private String message;
	private String salt;
}
