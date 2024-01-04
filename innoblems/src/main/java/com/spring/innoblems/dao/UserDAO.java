package com.spring.innoblems.dao;

import java.util.List;
import java.util.Map;

import com.spring.innoblems.dto.SkillDTO;
import com.spring.innoblems.dto.UserDTO;
import com.spring.innoblems.dto.UserProjectDTO;

public interface UserDAO {
	List getUserList(Map map);
	int getUserTotal(Map map);
	int addUser(UserDTO userDTO);
	void delUserSkill(SkillDTO skillDTO);
	void addUserSkill(SkillDTO skillDTO);
	void delUser(List list);
	UserDTO getUserDetail(UserDTO userDTO);
	void saveUser(UserDTO userDTO);
	List getUserProjectList(Map map);
	int getUserProjectTotal(Map map);
	List getAddUserProjectList(Map map);
	int getAddUserProjectTotal(Map map);
	void addUserProject(UserProjectDTO userProjectDTO);
	void delUserProject(Map deleteMap);
	void saveUserProject(UserProjectDTO userProjectDTO);
}
