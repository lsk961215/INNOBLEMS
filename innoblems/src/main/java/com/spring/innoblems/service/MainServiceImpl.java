package com.spring.innoblems.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.innoblems.dao.MainDAO;
import com.spring.innoblems.dto.UserDTO;

@Service
public class MainServiceImpl implements MainService {
	
	@Autowired
	MainDAO mainDAO;

	@Override
	public List getCodeList() {
		return mainDAO.getCodeList();
	}
}
