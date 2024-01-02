package com.spring.innoblems.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.innoblems.dto.ProjectDTO;
import com.spring.innoblems.dto.SkillDTO;
import com.spring.innoblems.dto.UserDTO;
import com.spring.innoblems.service.MainService;
import com.spring.innoblems.service.ProjectService;


@Controller
public class ProjectController {
	
	@Autowired
	ProjectService projectService;
	
	@Autowired
	MainService mainService;
	
	@ResponseBody
	@RequestMapping("/getProjectList")
	public Map getProjectList(HttpServletRequest request, ProjectDTO projectDTO) throws Exception {
		Map selectMap = new HashMap();
		
		int pageNum = 1;
		int countPerPage = 5;
		
		String str = projectDTO.getSkills();
		String[] skillArray = str.split(",");
		List skills = new ArrayList();
		
		for (int i = 0; i<skillArray.length; i++) {
			skills.add(skillArray[i]);
		}
		
		String tmp_pageNum = request.getParameter("pageNum");
		
		if(tmp_pageNum != null) {
			try { 
				pageNum = Integer.parseInt(tmp_pageNum);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		String tmp_countPerPage = request.getParameter("countPerPage");
		
		if(tmp_countPerPage != null) {
			try { 
				countPerPage = Integer.parseInt(tmp_countPerPage);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		selectMap.put("skills", skills);
		selectMap.put("projectDTO", projectDTO);
		selectMap.put("pageNum", pageNum);
		selectMap.put("countPerPage", countPerPage);
		
		Map projectMap = new HashMap();
		
		try {
			projectMap = projectService.getProjectList(selectMap);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("오류가 발생했습니다.");
		}
		
		return projectMap;
	}
	
	@ResponseBody
	@RequestMapping("/addProject")
	public int addProject(HttpServletRequest request, ProjectDTO projectDTO) throws Exception {
		
		try {
			int prjSeq = projectService.addProject(projectDTO);
			
			List<SkillDTO> skillList = new ArrayList();
			
			String tmp_skillArray = projectDTO.getSkills();
			
			String[] skillArray = tmp_skillArray.split(",");
			
			for (int i = 0; i<skillArray.length; i++) {
				SkillDTO skillDTO = new SkillDTO();
				
				skillDTO.setPrjSeq(prjSeq);
				skillDTO.setSkill(skillArray[i]);
				
				skillList.add(skillDTO);
			}
			
			projectService.addProjectSkill(skillList);
			
			return 0;
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("오류가 발생했습니다.");
			
			return 1;
		}
	}
	
	@ResponseBody
	@RequestMapping("/delProject")
	public int delProject(HttpServletRequest request, ProjectDTO projectDTO) throws Exception {
		String tmp_prjSeqList = request.getParameter("prjSeqList");
		
		String[] prjSeqArray = tmp_prjSeqList.split(",");
		List prjSeqList = new ArrayList();
		
		for (int i = 0; i<prjSeqArray.length; i++) {
			prjSeqList.add(prjSeqArray[i]);
		}
		
		try {
			projectService.delProject(prjSeqList);
			return 0;
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("오류가 발생했습니다.");
			return 1;
		}
	}
	
	@RequestMapping("/getProjectDetail")
	public String getProjectDetail (HttpServletRequest request, ProjectDTO projectDTO, Model model) {
		List codeList = mainService.getCodeList();
		
		projectDTO = projectService.getProjectDetail(projectDTO);
		
		model.addAttribute("codeList", codeList);
		model.addAttribute("projectDTO", projectDTO);
		
		return "projectDetail";
	}
	
	@ResponseBody
	@RequestMapping("/saveProject")
	public int saveProject(HttpServletRequest request, ProjectDTO projectDTO) throws Exception {
		
		try {
			projectService.saveProject(projectDTO);
			
			List<SkillDTO> skillList = new ArrayList();
			
			String tmp_skillArray = projectDTO.getSkills();
			
			String[] skillArray = tmp_skillArray.split(",");
			
			for (int i = 0; i<skillArray.length; i++) {
				SkillDTO skillDTO = new SkillDTO();
				
				skillDTO.setPrjSeq(projectDTO.getPrjSeq());
				skillDTO.setSkill(skillArray[i]);
				
				skillList.add(skillDTO);
			}
			
			System.out.println("prjSeq saveProject = " + projectDTO.getPrjSeq());
			
			projectService.addProjectSkill(skillList);
			
			return 0;
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("오류가 발생했습니다.");
			
			return 1;
		}
	}
}