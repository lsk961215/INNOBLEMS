package com.innoblems.controller;

import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.innoblems.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
	@RequestMapping(value = "/getUserList", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		List userList = userService.getUserList();
		model.addAttribute("userList", userList);
		return "userList";
	}
	
}