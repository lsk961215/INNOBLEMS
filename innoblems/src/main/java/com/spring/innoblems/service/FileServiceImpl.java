package com.spring.innoblems.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.innoblems.dao.FileDAO;

@Service
public class FileServiceImpl implements FileService{
	
	@Autowired
	FileDAO fileDAO;

	@Override
	public void userImage(String str) {
		// TODO Auto-generated method stub
		
	}

}
