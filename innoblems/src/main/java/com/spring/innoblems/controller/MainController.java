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
		return "main";
	}
	
	@ResponseBody
	@RequestMapping("/getUserList")
	public List getUserList(UserDTO userDTO) throws Exception {
		String str = userDTO.getSkills();
		String[] skillArray = str.split(",");
		List skills = new ArrayList();
		
		for (int i = 0; i<skillArray.length; i++) {
			skills.add(skillArray[i]);
		}
		
		Map selectMap = new HashMap();
		
		selectMap.put("skills", skills);
		selectMap.put("userDTO", userDTO);
		
		List userList = new ArrayList();
		
		try {
			userList = mainService.getUserList(selectMap);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("오류가 발생했습니다.");
		}
		
		return userList;
	}
	
}
