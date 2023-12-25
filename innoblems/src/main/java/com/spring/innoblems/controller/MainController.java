package com.spring.innoblems.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.Enumeration;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.reflection.SystemMetaObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import com.spring.innoblems.dto.UserDTO;
import com.spring.innoblems.service.MainService;

@Controller
public class MainController {
	
	@Autowired
	MainService mainService;
	
	@RequestMapping("/")
	public String goMain(Model model) {
		List codeList = mainService.getCodeList();
		
		model.addAttribute("codeList", codeList);
		
		return "main";
	}
	
	@RequestMapping("/addUser")
	public String addUser(Model model) {
		model.addAttribute("addUser", true);
		
		return "user";
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
			userMap = mainService.getUserList(selectMap);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("오류가 발생했습니다.");
		}
		
		return userMap;
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
			mainService.delUser(usrSeqList);
			return 0;
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("오류가 발생했습니다.");
			return 1;
		}
	}
}
