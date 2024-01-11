package com.spring.innoblems.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserProjectDTO {
	private int usrSeq;
	private int prjSeq;
	private String prjNm;
	private String usrNm;
	private String stCD;
	private String grCD;
	private String raCD;
	private String cusCD;
	private String skills;
	private String prjSTDT;
	private String prjEDDT;
	private String minSTDT;
	private String maxSTDT;
	private String minEDDT;
	private String maxEDDT;
	private String usrPrjINDT;
	private String usrPrjOTDT;
	private String rlCD;
	private String prjSeqList;
	private String usrPrjINDTList;
	private String usrPrjOTDTList;
	private String rlCDList;
}
