package com.spring.innoblems.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.innoblems.dto.SkillDTO;
import com.spring.innoblems.dto.UserDTO;
import com.spring.innoblems.dto.UserProjectDTO;

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
	public void delUserSkill(SkillDTO skillDTO) {
		sqlSession.delete("skill.delUserSkill", skillDTO);
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
	public void saveUser(UserDTO userDTO) {
		sqlSession.update("user.saveUser", userDTO);
		return;
	}

	@Override
	public List getUserProjectList(Map map) {
		return sqlSession.selectList("userProject.getUserProjectList", map);
	}

	@Override
	public int getUserProjectTotal(Map map) {
		return sqlSession.selectOne("userProject.getUserProjectTotal", map);
	}

	@Override
	public List getAddUserProjectList(Map map) {
		return sqlSession.selectList("userProject.getAddUserProjectList", map);
	}

	@Override
	public int getAddUserProjectTotal(Map map) {
		return sqlSession.selectOne("userProject.getAddUserProjectTotal", map);
	}

	@Override
	public void addUserProject(UserProjectDTO userProjectDTO) {
		sqlSession.insert("userProject.addUserProject", userProjectDTO);
	}

	@Override
	public void delUserProject(Map deleteMap) {
		sqlSession.delete("userProject.delUserProject", deleteMap);
		return;
	}

	@Override
	public void saveUserProject(UserProjectDTO userProjectDTO) {
		sqlSession.update("userProject.saveUserProject", userProjectDTO);
		return;
	}

	@Override
	public UserDTO login(UserDTO userDTO) {
		return sqlSession.selectOne("user.login", userDTO);
	}
}
