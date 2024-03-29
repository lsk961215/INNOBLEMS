package com.spring.innoblems.service;

import java.util.Map;

import com.spring.innoblems.dto.BoardDTO;
import com.spring.innoblems.dto.UserDTO;

public interface BoardService {
	Map getBoardList(Map selectMap);
	void addBoard(BoardDTO boardDTO);
	void addBoard2(BoardDTO boardDTO);
	BoardDTO getBoardDetail(BoardDTO boardDTO);
	void editBoard(BoardDTO boardDTO);
}
