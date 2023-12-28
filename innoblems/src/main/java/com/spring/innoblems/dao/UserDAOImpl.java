package com.spring.innoblems.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.innoblems.dto.SkillDTO;
import com.spring.innoblems.dto.UserDTO;

@Repository
public class UserDAOImpl implements UserDAO {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public int addUser(UserDTO userDTO) {
		sqlSession.insert("user.addUser", userDTO);
		
		return userDTO.getUsrSeq();
	}
	
	@Override
	public void addUserSkill(SkillDTO skillDTO) {
		sqlSession.insert("skill.addUserSkill", skillDTO);
	}

	@Override
	public List getUserList(Map map) {
		return sqlSession.selectList("user.getUserList", map);
	}
	
	@Override
	public int getUserTotal(Map map) {
		return sqlSession.selectOne("user.getUserTotal", map);
	}

	@Override
	public void delUser(List list) {
		sqlSession.delete("user.delUser", list);
		return;
	}

	@Override
	public UserDTO getUserDetail(UserDTO userDTO) {
		return sqlSession.selectOne("user.getUserDetail", userDTO);
	}

	@Override
	public int saveUser(UserDTO userDTO) {
		sqlSession.update("user.saveUser", userDTO);
		return userDTO.getUsrSeq();
	}
}
