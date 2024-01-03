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
		
		return "userList";
	}
	
	@RequestMapping("/goUserListPage")
	public String goUserListPage(Model model) {
		List codeList = mainService.getCodeList();
		
		model.addAttribute("codeList", codeList);
		
		return "userList";
	}
	
	@RequestMapping("/goProjectListPage")
	public String goProjectListPage(Model model) {
		
		List codeList = mainService.getCodeList();
		
		model.addAttribute("codeList", codeList);
		
		return "projectList";
	}
	
	@RequestMapping("/goAddUserPage")
	public String goAddUserPage(Model model, HttpServletRequest request, UserDTO userDTO) {
		
		List codeList = mainService.getCodeList();
		
		model.addAttribute("codeList", codeList);
		
//		model.addAttribute("userParam", userDTO);
		
		return "addUser";
	}
	
	@RequestMapping("/goAddProjectPage")
	public String goAddProjectPage(Model model) {
		
		List codeList = mainService.getCodeList();
		
		model.addAttribute("codeList", codeList);
		
		return "addProject";
	}
}
