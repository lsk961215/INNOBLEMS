package com.spring.innoblems.dto;

import java.util.List;

public class SkillDTO {
	private int usrSeq;
	private int prjSeq;
	private String skill;
	
	public int getUsrSeq() {
		return usrSeq;
	}
	public void setUsrSeq(int usrSeq) {
		this.usrSeq = usrSeq;
	}
	public int getPrjSeq() {
		return prjSeq;
	}
	public void setPrjSeq(int prjSeq) {
		this.prjSeq = prjSeq;
	}
	public String getSkill() {
		return skill;
	}
	public void setSkill(String skill) {
		this.skill = skill;
	}
	
	@Override
	public String toString() {
		return "SkillDTO [usrSeq=" + usrSeq + ", prjSeq=" + prjSeq + ", skill=" + skill + "]";
	}

}
