package com.spring.innoblems.dao;

import java.util.List;
import java.util.Map;

import com.spring.innoblems.dto.BoardDTO;
import com.spring.innoblems.dto.UserDTO;

public interface BoardDAO {
	List getBoardList(Map map);
	int getBoardTotal(Map map);
	void addBoard(BoardDTO boardDTO);
}
