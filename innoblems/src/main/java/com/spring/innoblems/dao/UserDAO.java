package com.spring.innoblems.dao;

import java.util.List;
import java.util.Map;

import com.spring.innoblems.dto.SkillDTO;
import com.spring.innoblems.dto.UserDTO;

public interface UserDAO {
	List getUserList(Map map);
	int getUserTotal(Map map);
	int addUser(UserDTO userDTO);
	void delUserSkill(SkillDTO skillDTO);
	void addUserSkill(SkillDTO skillDTO);
	void delUser(List list);
	UserDTO getUserDetail(UserDTO userDTO);
	void saveUser(UserDTO userDTO);
}
