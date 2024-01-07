package com.spring.innoblems.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.innoblems.dto.ProjectDTO;
import com.spring.innoblems.dto.SkillDTO;
import com.spring.innoblems.dto.UserProjectDTO;

@Repository
public class ProjectDAOImpl implements ProjectDAO {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public List getProjectList(Map map) {
		return sqlSession.selectList("project.getProjectList", map);
	}

	@Override
	public int getProjectTotal(Map map) {
		return sqlSession.selectOne("project.getProjectTotal", map);
	}

	@Override
	public int addProject(ProjectDTO projectDTO) {
		sqlSession.insert("project.addProject", projectDTO);
		
		return projectDTO.getPrjSeq();
	}

	@Override
	public void delProjectSkill(SkillDTO skillDTO) {
		sqlSession.delete("skill.delProjectSkill", skillDTO);
	}

	@Override
	public void addProjectSkill(SkillDTO skillDTO) {
		sqlSession.insert("skill.addProjectSkill", skillDTO);
	}

	@Override
	public ProjectDTO getProjectDetail(ProjectDTO projectDTO) {
		return sqlSession.selectOne("project.getProjectDetail", projectDTO);
	}

	@Override
	public void saveProject(ProjectDTO projectDTO) {
		sqlSession.update("project.saveProject", projectDTO);
		return;
	}

	@Override
	public void delProject(List list) {
		sqlSession.delete("project.delProject", list);
		return;
	}

	@Override
	public List getProjectUserList(Map map) {
		return sqlSession.selectList("projectUser.getProjectUserList", map);
	}

	@Override
	public int getProjectUserTotal(Map map) {
		return sqlSession.selectOne("projectUser.getProjectUserTotal", map);
	}

	@Override
	public List getAddProjectUserList(Map map) {
		return sqlSession.selectList("projectUser.getAddProjectUserList", map);
	}

	@Override
	public int getAddProjectUserTotal(Map map) {
		return sqlSession.selectOne("projectUser.getAddProjectUserTotal", map);
	}

	@Override
	public void delProjectUser(Map deleteMap) {
		sqlSession.delete("projectUser.delProjectUser", deleteMap);
		return;
	}

	@Override
	public void addProjectUser(UserProjectDTO userProjectDTO) {
		sqlSession.insert("projectUser.addProjectUser", userProjectDTO);
	}

	@Override
	public void saveProjectUser(UserProjectDTO userProjectDTO) {
		sqlSession.update("projectUser.saveProjectUser", userProjectDTO);
		return;
	}


}
