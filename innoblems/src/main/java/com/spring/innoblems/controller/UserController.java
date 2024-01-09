package com.spring.innoblems.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.innoblems.aop.SHA256;
import com.spring.innoblems.dto.SkillDTO;
import com.spring.innoblems.dto.UserDTO;
import com.spring.innoblems.dto.UserProjectDTO;
import com.spring.innoblems.service.MainService;
import com.spring.innoblems.service.UserService;


@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	MainService mainService;
	
	@ResponseBody
	@RequestMapping("/login")
	public UserDTO login(HttpServletRequest request, Model model, UserDTO userDTO) {
		HttpSession session = request.getSession();
		
		try {
			userDTO = userService.login(userDTO);
			
			if(userDTO.getUsrSeq() != 0) {
				session.setAttribute("userDTO", userDTO);
				return userDTO;
			} else {
				UserDTO failUserDTO = new UserDTO();
				failUserDTO.setMessage("아이디 또는 비밀번호가 일치하지 않습니다.");
				
				return failUserDTO;
			}
		} catch (NullPointerException e) {
			System.out.println(e);
			UserDTO failUserDTO = new UserDTO();
			failUserDTO.setMessage("아이디 또는 비밀번호가 일치하지 않습니다.");
			
			return failUserDTO;
		}
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request, Model model, UserDTO userDTO) {
		HttpSession session = request.getSession();
		
		session.invalidate();
		
		return "login";
	}
	
	@ResponseBody
	@RequestMapping("/getUserList")
	public Map getUserList(HttpServletRequest request, UserDTO userDTO) throws Exception {
		Map selectMap = new HashMap();
		
		int pageNum = 1;
		int countPerPage = 5;
		
		String str = userDTO.getSkills();
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
		selectMap.put("userDTO", userDTO);
		selectMap.put("pageNum", pageNum);
		selectMap.put("countPerPage", countPerPage);
		
		Map userMap = new HashMap();
		
		try {
			userMap = userService.getUserList(selectMap);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("오류가 발생했습니다.");
		}
		
		return userMap;
	}
	
	@RequestMapping("/goAddUser")
	public String goAddUser(Model model, HttpServletRequest request, UserDTO userDTO) {
		
		List codeList = mainService.getCodeList();
		
		model.addAttribute("codeList", codeList);
		
		return "addUser";
	}
	
	@ResponseBody
	@RequestMapping("/addUser")
	public int addUser(HttpServletRequest request, UserDTO userDTO) throws Exception {
		
		try {
			String join_pw = userDTO.getUsrPw();
			
			new SHA256();
			
			String salt = SHA256.createSalt(join_pw);
			
			String pw = SHA256.encrypt(join_pw, salt);
			
			userDTO.setUsrPw(pw);
			userDTO.setSalt(salt);
			
			int usrSeq = userService.addUser(userDTO);
			
			List<SkillDTO> skillList = new ArrayList();
			
			String tmp_skillArray = userDTO.getSkills();
			
			String[] skillArray = tmp_skillArray.split(",");
			
			for (int i = 0; i<skillArray.length; i++) {
				SkillDTO skillDTO = new SkillDTO();
				
				skillDTO.setUsrSeq(usrSeq);
				skillDTO.setSkill(skillArray[i]);
				
				skillList.add(skillDTO);
			}
			
			userService.addUserSkill(skillList);
			
			return 0;
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("오류가 발생했습니다.");
			
			return 1;
		}
	}
	
	@ResponseBody
	@RequestMapping("/delUser")
	public int delUser(HttpServletRequest request, UserDTO userDTO) throws Exception {
		String tmp_usrSeqList = request.getParameter("usrSeqList");
		
		String[] usrSeqArray = tmp_usrSeqList.split(",");
		List usrSeqList = new ArrayList();
		
		for (int i = 0; i<usrSeqArray.length; i++) {
			usrSeqList.add(usrSeqArray[i]);
		}
		
		try {
			userService.delUser(usrSeqList);
			return 0;
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("오류가 발생했습니다.");
			return 1;
		}
	}
	
	@RequestMapping("/getUserDetail")
	public String getUserDetail (HttpServletRequest request, UserDTO userDTO, Model model) {
		List codeList = mainService.getCodeList();
		
		userDTO = userService.getUserDetail(userDTO);
		
		model.addAttribute("codeList", codeList);
		model.addAttribute("userDTO", userDTO);
		
		return "userDetail";
	}
	
	@ResponseBody
	@RequestMapping("/saveUser")
	public int saveUser(HttpServletRequest request, UserDTO userDTO) throws Exception {
		
		try {
			String save_pw = userDTO.getUsrPw();
			
			new SHA256();
			
			String salt = SHA256.createSalt(save_pw);
			
			String pw = SHA256.encrypt(save_pw, salt);
			
			userDTO.setUsrPw(pw);
			userDTO.setSalt(salt);
			
			userService.saveUser(userDTO);
			
			List<SkillDTO> skillList = new ArrayList();
			
			String tmp_skillArray = userDTO.getSkills();
			
			String[] skillArray = tmp_skillArray.split(",");
			
			for (int i = 0; i<skillArray.length; i++) {
				SkillDTO skillDTO = new SkillDTO();
				
				skillDTO.setUsrSeq(userDTO.getUsrSeq());
				skillDTO.setSkill(skillArray[i]);
				
				skillList.add(skillDTO);
			}
			
			System.out.println("usrSeq saveUser = " + userDTO.getUsrSeq());
			
			userService.addUserSkill(skillList);
			
			return 0;
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("오류가 발생했습니다.");
			
			return 1;
		}
	}
	
	@RequestMapping("/getUserProject")
	public String getUserProject (HttpServletRequest request, UserDTO userDTO, Model model) {
		List menuList = mainService.getMenuList();
		model.addAttribute("menuList", menuList);
		List codeList = mainService.getCodeList();
		
		userDTO = userService.getUserDetail(userDTO);
		
		model.addAttribute("codeList", codeList);
		
		model.addAttribute("userDTO", userDTO);
		
		return "userProject";
	}
	
	@ResponseBody
	@RequestMapping("/getUserProjectList")
	public Map getUserProjectList (HttpServletRequest request, UserProjectDTO userProjectDTO, Model model) {
		List codeList = mainService.getCodeList();
		
		model.addAttribute("codeList", codeList);
		
		Map selectMap = new HashMap();
		
		int pageNum = 1;
		int countPerPage = 5;
		
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
		
		selectMap.put("userProjectDTO", userProjectDTO);
		selectMap.put("pageNum", pageNum);
		selectMap.put("countPerPage", countPerPage);
		
		Map userProjectMap = new HashMap();
		
		try {
			userProjectMap = userService.getUserProjectList(selectMap);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("오류가 발생했습니다.");
		}
		
		return userProjectMap;
	}
	
	@RequestMapping("/goAddUserProject")
	public String addUserProject(Model model, UserProjectDTO userProjectDTO) {
		
		List menuList = mainService.getMenuList();
		model.addAttribute("menuList", menuList);
		List codeList = mainService.getCodeList();
		
		model.addAttribute("codeList", codeList);
		
		model.addAttribute("userProjectDTO", userProjectDTO);
		
		return "addUserProject";
	}
	
	@ResponseBody
	@RequestMapping("/getAddUserProjectList")
	public Map getAddUserProjectList(HttpServletRequest request, Model model, UserProjectDTO userProjectDTO) {
		
		Map selectMap = new HashMap();
		
		int pageNum = 1;
		int countPerPage = 5;
		
		String str = userProjectDTO.getSkills();
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
		selectMap.put("userProjectDTO", userProjectDTO);
		selectMap.put("pageNum", pageNum);
		selectMap.put("countPerPage", countPerPage);
		
		Map addUserProjectMap = new HashMap();
		
		try {
			addUserProjectMap = userService.getAddUserProjectList(selectMap);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("오류가 발생했습니다.");
		}
		
		return addUserProjectMap;
	}
	
	@ResponseBody
	@RequestMapping("/addUserProject")
	public int addUserProject(HttpServletRequest request, Model model, UserProjectDTO userProjectDTO) {
		Map insertMap = new HashMap();
		
		String tmp_prjSeqList = request.getParameter("prjSeqList");
			
		String[] prjSeqArray = tmp_prjSeqList.split(",");
		List prjSeqList = new ArrayList();
			
		for (int i = 0; i<prjSeqArray.length; i++) {
			prjSeqList.add(prjSeqArray[i]);
		}
		
		insertMap.put("userProjectDTO", userProjectDTO);
		insertMap.put("prjSeqList", prjSeqList);
		
		try {
			userService.addUserProject(insertMap);
			return 0;
		} catch(Exception e){
			e.printStackTrace();
			System.out.println("오류가 발생했습니다.");
			return 1;
		}
	}
	
	@ResponseBody
	@RequestMapping("/delUserProject")
	public int delUserProject(HttpServletRequest request, Model model, UserProjectDTO userProjectDTO) {
		Map deleteMap = new HashMap();
		
		String tmp_prjSeqList = request.getParameter("prjSeqList");
			
		String[] prjSeqArray = tmp_prjSeqList.split(",");
		List prjSeqList = new ArrayList();
			
		for (int i = 0; i<prjSeqArray.length; i++) {
			prjSeqList.add(prjSeqArray[i]);
		}
		
		deleteMap.put("userProjectDTO", userProjectDTO);
		deleteMap.put("prjSeqList", prjSeqList);
		
		
		try {
			userService.delUserProject(deleteMap);
			return 0;
		} catch(Exception e){
			e.printStackTrace();
			System.out.println("오류가 발생했습니다.");
			return 1;
		}
	}
	
	@ResponseBody
	@RequestMapping("/saveUserProject")
	public int saveUserProject(HttpServletRequest request, Model model, UserProjectDTO userProjectDTO) {
		String tmp_prjSeqList = request.getParameter("prjSeqList");
		String tmp_usrPrjINDTList = request.getParameter("usrPrjINDTList");
		String tmp_usrPrjOTDTList = request.getParameter("usrPrjOTDTList");
		String tmp_rlCDList = request.getParameter("rlCDList");
			
		String[] prjSeqArray = tmp_prjSeqList.split(",");
		String[] usrPrjINDTArray = tmp_usrPrjINDTList.split(",");
		String[] usrPrjOTDTArray = tmp_usrPrjOTDTList.split(",");
		String[] rlCDArray = tmp_rlCDList.split(",");
			
		List updateList= new ArrayList();
		
		for (int i = 0; i<prjSeqArray.length; i++) {
			UserProjectDTO tmp_userProjectDTO = new UserProjectDTO();
			
			int usrSeq = userProjectDTO.getUsrSeq();
			int prjSeq = Integer.parseInt(prjSeqArray[i]);
			String usrPrjINDT = usrPrjINDTArray[i];
			String usrPrjOTDT = usrPrjOTDTArray[i];
			String rlCD = rlCDArray[i];
			
			tmp_userProjectDTO.setUsrSeq(usrSeq);
			tmp_userProjectDTO.setPrjSeq(prjSeq);
			tmp_userProjectDTO.setUsrPrjINDT(usrPrjINDT);
			tmp_userProjectDTO.setUsrPrjOTDT(usrPrjOTDT);
			tmp_userProjectDTO.setRlCD(rlCD);
			
			updateList.add(tmp_userProjectDTO);
		}
		
		try {
			userService.saveUserProject(updateList);
			return 0;
		} catch(Exception e){
			e.printStackTrace();
			System.out.println("오류가 발생했습니다.");
			return 1;
		}
	}
}
