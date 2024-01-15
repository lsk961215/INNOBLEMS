package com.spring.innoblems.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.innoblems.dto.BoardDTO;

@Repository
public class BoardDAOImpl implements BoardDAO{
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List getBoardList(Map map) {
		return sqlSession.selectList("board.getBoardList", map);
	}

	@Override
	public int getBoardTotal(Map map) {
		return sqlSession.selectOne("board.getBoardTotal", map);
	}

	@Override
	public void addBoard(BoardDTO boardDTO) {
		sqlSession.insert("board.addBoard", boardDTO);
		return;
	}
	
	@Override
	public void addBoard2(BoardDTO boardDTO) {
		sqlSession.insert("board.addBoard2", boardDTO);
		return;
	}

	@Override
	public BoardDTO getBoardDetail(BoardDTO boardDTO) {
		return sqlSession.selectOne("board.getBoardDetail", boardDTO);
	}

}
