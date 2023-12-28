package com.spring.innoblems.service;

import java.util.List;
import java.util.Map;

import com.spring.innoblems.dto.SkillDTO;
import com.spring.innoblems.dto.UserDTO;

public interface UserService {
	Map getUserList(Map map);
	int addUser(UserDTO userDTO);
	void addUserSkill(List<SkillDTO> skillList);
	void delUser(List list);
	UserDTO getUserDetail(UserDTO userDTO);
	int saveUser(UserDTO userDTO);
}