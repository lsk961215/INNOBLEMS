package com.spring.innoblems.dao;

import java.util.List;
import java.util.Map;

import com.spring.innoblems.dto.ProjectDTO;
import com.spring.innoblems.dto.SkillDTO;
import com.spring.innoblems.dto.UserDTO;
import com.spring.innoblems.dto.UserProjectDTO;

public interface ProjectDAO {
	List getProjectList(Map map);
	int getProjectTotal(Map map);
	int addProject(ProjectDTO projectDTO);
	void delProjectSkill(SkillDTO skillDTO);
	void addProjectSkill(SkillDTO skillDTO);
	ProjectDTO getProjectDetail(ProjectDTO projectDTO);
	void saveProject(ProjectDTO projectDTO);
	void delProject(List list);
	List getProjectUserList(Map map);
	int getProjectUserTotal(Map map);
	List getAddProjectUserList(Map map);
	int getAddProjectUserTotal(Map map);
	void delProjectUser(Map deleteMap);
	void addProjectUser(UserProjectDTO userProjectDTO);
	void saveProjectUser(UserProjectDTO userProjectDTO);
}
