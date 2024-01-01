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
}
