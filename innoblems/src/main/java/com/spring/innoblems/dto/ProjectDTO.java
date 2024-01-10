package com.spring.innoblems.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
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
}
