package com.spring.innoblems.service;

import java.util.List;
import java.util.Map;

import com.spring.innoblems.dto.ProjectDTO;
import com.spring.innoblems.dto.SkillDTO;
import com.spring.innoblems.dto.UserDTO;

public interface ProjectService {
	Map getProjectList(Map selectMap);
	int addProject(ProjectDTO projectDTO);
	void addProjectSkill(List<SkillDTO> skillList);
	ProjectDTO getProjectDetail(ProjectDTO projectDTO);
	void saveProject(ProjectDTO projectDTO);
	void delProject(List list);
	Map getProjectUserList(Map selectMap);
	Map getAddProjectUserList(Map selectMap);
	void delProjectUser(Map deleteMap);
	void addProjectUser(Map insertMap);
	void saveProjectUser(List updateList);
}
