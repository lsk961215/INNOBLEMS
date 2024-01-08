package com.spring.innoblems.service;

import java.util.List;
import java.util.Map;

import com.spring.innoblems.dto.SkillDTO;
import com.spring.innoblems.dto.UserDTO;

public interface UserService {
	Map getUserList(Map selectMap);
	int addUser(UserDTO userDTO);
	void addUserSkill(List<SkillDTO> skillList);
	void delUser(List list);
	UserDTO getUserDetail(UserDTO userDTO);
	void saveUser(UserDTO userDTO);
	Map getUserProjectList(Map selectMap);
	Map getAddUserProjectList(Map selectMap);
	void addUserProject(Map insertMap);
	void delUserProject(Map deleteMap);
	void saveUserProject(List updateList);
	UserDTO login(UserDTO userDTO);
}
