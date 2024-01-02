package com.spring.innoblems.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.innoblems.dto.ProjectDTO;
import com.spring.innoblems.dto.SkillDTO;

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


}
