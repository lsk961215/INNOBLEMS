package com.spring.innoblems.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.innoblems.dao.ProjectDAO;
import com.spring.innoblems.dto.ProjectDTO;
import com.spring.innoblems.dto.SkillDTO;

@Service
public class ProjectServiceImpl implements ProjectService {

	@Autowired
	ProjectDAO projectDAO;

	@Override
	public Map getProjectList(Map selectMap) {
		Map resultMap = new HashMap();
		
		int pageNum = (Integer) selectMap.get("pageNum");
		int countPerPage = (Integer) selectMap.get("countPerPage");
		
		int startNum = 0;
		int endNum = 0;
		
		startNum = (pageNum-1)*countPerPage+1;
		endNum = pageNum*countPerPage;
		
		selectMap.put("startNum", startNum);
		selectMap.put("endNum", endNum);
		
		List projectList = projectDAO.getProjectList(selectMap);
		
		int total = projectDAO.getProjectTotal(selectMap);
		
		int groupCount = 5;
		
		int totalPaging = (int) Math.ceil((double)total / countPerPage);
		
		int position = (int) Math.ceil((double)pageNum / groupCount);
		
		int beginPaging = (position-1) * groupCount + 1;
		int endPaging = position * groupCount;
		
		if(endPaging > totalPaging) {
			endPaging = totalPaging;
		}
		
		resultMap.put("beginPaging", beginPaging);
		resultMap.put("endPaging", endPaging);
		resultMap.put("totalPaging", totalPaging);
		resultMap.put("projectList", projectList);
		resultMap.put("pageNum", pageNum);
		
		return resultMap;
	}

	@Override
	public int addProject(ProjectDTO projectDTO) {
		return projectDAO.addProject(projectDTO);
	}

	@Override
	public void addProjectSkill(List<SkillDTO> skillList) {
		SkillDTO tmp_skillDTO = (SkillDTO) skillList.get(0);
		
		projectDAO.delProjectSkill(tmp_skillDTO);
		
		for(int i = 0; i<skillList.size(); i++) {
			SkillDTO skillDTO = (SkillDTO) skillList.get(i);
			projectDAO.addProjectSkill(skillDTO);
		}
	}

	@Override
	public ProjectDTO getProjectDetail(ProjectDTO projectDTO) {
		return projectDAO.getProjectDetail(projectDTO);
	}

	@Override
	public void saveProject(ProjectDTO projectDTO) {
		projectDAO.saveProject(projectDTO);
		return;
	}

	@Override
	public void delProject(List list) {
		projectDAO.delProject(list);
		return;
	}

	@Override
	public Map getProjectUserList(Map selectMap) {
		Map resultMap = new HashMap();
		
		int pageNum = (Integer) selectMap.get("pageNum");
		int countPerPage = (Integer) selectMap.get("countPerPage");
		
		int startNum = 0;
		int endNum = 0;
		
		startNum = (pageNum-1)*countPerPage+1;
		endNum = pageNum*countPerPage;
		
		selectMap.put("startNum", startNum);
		selectMap.put("endNum", endNum);
		
		List projectUserList = projectDAO.getProjectUserList(selectMap);
		
		int total = projectDAO.getProjectUserTotal(selectMap);
		
		int groupCount = 5;
		
		int totalPaging = (int) Math.ceil((double)total / countPerPage);
		
		int position = (int) Math.ceil((double)pageNum / groupCount);
		
		int beginPaging = (position-1) * groupCount + 1;
		int endPaging = position * groupCount;
		
		if(endPaging > totalPaging) {
			endPaging = totalPaging;
		}
		
		resultMap.put("beginPaging", beginPaging);
		resultMap.put("endPaging", endPaging);
		resultMap.put("totalPaging", totalPaging);
		resultMap.put("projectUserList", projectUserList);
		resultMap.put("pageNum", pageNum);
		
		return resultMap;
	}

	@Override
	public Map getAddProjectUserList(Map selectMap) {
		Map resultMap = new HashMap();
		
		int pageNum = (Integer) selectMap.get("pageNum");
		int countPerPage = (Integer) selectMap.get("countPerPage");
		
		int startNum = 0;
		int endNum = 0;
		
		startNum = (pageNum-1)*countPerPage+1;
		endNum = pageNum*countPerPage;
		
		selectMap.put("startNum", startNum);
		selectMap.put("endNum", endNum);
		
		List projectUserList = projectDAO.getAddProjectUserList(selectMap);
		
		int total = projectDAO.getAddProjectUserTotal(selectMap);
		
		int groupCount = 5;
		
		int totalPaging = (int) Math.ceil((double)total / countPerPage);
		
		int position = (int) Math.ceil((double)pageNum / groupCount);
		
		int beginPaging = (position-1) * groupCount + 1;
		int endPaging = position * groupCount;
		
		if(endPaging > totalPaging) {
			endPaging = totalPaging;
		}
		
		resultMap.put("beginPaging", beginPaging);
		resultMap.put("endPaging", endPaging);
		resultMap.put("totalPaging", totalPaging);
		resultMap.put("projectUserList", projectUserList);
		resultMap.put("pageNum", pageNum);
		
		return resultMap;
	}

	
	
	
}
