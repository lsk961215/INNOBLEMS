package com.spring.innoblems.dao;

import java.util.List;
import java.util.Map;

import com.spring.innoblems.dto.SkillDTO;
import com.spring.innoblems.dto.UserDTO;

public interface UserDAO {
	List getUserList(Map map);
	int getUserTotal(Map map);
	int addUser(UserDTO userDTO);
	void addUserSkill(SkillDTO skillDTO);
	void delUser(List list);
	UserDTO getUserDetail(UserDTO userDTO);
	int saveUser(UserDTO userDTO);
}
