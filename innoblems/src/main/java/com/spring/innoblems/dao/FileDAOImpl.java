package com.spring.innoblems.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FileDAOImpl implements FileDAO{

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void userImage(String str) {
		// TODO Auto-generated method stub
		
	}
	
}
