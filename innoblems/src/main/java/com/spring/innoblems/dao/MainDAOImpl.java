package com.spring.innoblems.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.innoblems.dto.UserDTO;

@Repository
public class MainDAOImpl implements MainDAO{
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public List getUserList(Map map) {
		return sqlSession.selectList("user.getUserList", map);
	}
}
