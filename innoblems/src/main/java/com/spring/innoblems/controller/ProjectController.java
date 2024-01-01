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
	
//	@ResponseBody
//	@RequestMapping("/delUser")
//	public int delUser(HttpServletRequest request, UserDTO userDTO) throws Exception {
//		String tmp_usrSeqList = request.getParameter("usrSeqList");
//		
//		String[] usrSeqArray = tmp_usrSeqList.split(",");
//		List usrSeqList = new ArrayList();
//		
//		for (int i = 0; i<usrSeqArray.length; i++) {
//			usrSeqList.add(usrSeqArray[i]);
//		}
//		
//		try {
//			userService.delUser(usrSeqList);
//			return 0;
//		}catch(Exception e){
//			e.printStackTrace();
//			System.out.println("오류가 발생했습니다.");
//			return 1;
//		}
//	}
//	
//	@RequestMapping("/getUserDetail")
//	public String getUserDetail (HttpServletRequest request, UserDTO userDTO, Model model) {
//		List codeList = mainService.getCodeList();
//		
//		userDTO = userService.getUserDetail(userDTO);
//		
//		model.addAttribute("codeList", codeList);
//		model.addAttribute("userDTO", userDTO);
//		
//		return "userDetail";
//	}
//	
//	@ResponseBody
//	@RequestMapping("/saveUser")
//	public int saveUser(HttpServletRequest request, UserDTO userDTO) throws Exception {
//		
//		try {
//			userService.saveUser(userDTO);
//			
//			List<SkillDTO> skillList = new ArrayList();
//			
//			String tmp_skillArray = userDTO.getSkills();
//			
//			String[] skillArray = tmp_skillArray.split(",");
//			
//			for (int i = 0; i<skillArray.length; i++) {
//				SkillDTO skillDTO = new SkillDTO();
//				
//				skillDTO.setUsrSeq(userDTO.getUsrSeq());
//				skillDTO.setSkill(skillArray[i]);
//				
//				skillList.add(skillDTO);
//			}
//			
//			System.out.println("usrSeq saveUser = " + userDTO.getUsrSeq());
//			
//			userService.addUserSkill(skillList);
//			
//			return 0;
//		}catch(Exception e){
//			e.printStackTrace();
//			System.out.println("오류가 발생했습니다.");
//			
//			return 1;
//		}
//	}
}