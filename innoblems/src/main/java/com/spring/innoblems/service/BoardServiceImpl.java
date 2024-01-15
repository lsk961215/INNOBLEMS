package com.spring.innoblems.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.innoblems.dao.BoardDAO;
import com.spring.innoblems.dto.BoardDTO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardDAO boardDAO;

	@Override
	public Map getBoardList(Map selectMap) {
		Map resultMap = new HashMap();
		
		int pageNum = (Integer) selectMap.get("pageNum");
		int countPerPage = (Integer) selectMap.get("countPerPage");
		
		int startNum = 0;
		int endNum = 0;
		
		startNum = (pageNum-1)*countPerPage+1;
		endNum = pageNum*countPerPage;
		
		selectMap.put("startNum", startNum);
		selectMap.put("endNum", endNum);
		
		List boardList = boardDAO.getBoardList(selectMap);
		
		int total = boardDAO.getBoardTotal(selectMap);
		
		int groupCount = 5;
		
		int totalPaging = (int) Math.ceil((double)total / countPerPage);
		
		int position = (int) Math.ceil((double)pageNum / groupCount);
		
		int beginPaging = (position-1) * groupCount + 1;
		int endPaging = position * groupCount;
		
		if(endPaging > totalPaging) {
			endPaging = totalPaging;
		}
		
		resultMap.put("beginPaging", beginPaging);
		resultMap.put("endPaging", endPaging);
		resultMap.put("totalPaging", totalPaging);
		resultMap.put("boardList", boardList);
		resultMap.put("pageNum", pageNum);
		
		return resultMap;
	}

	@Override
	public void addBoard(BoardDTO boardDTO) {
		boardDAO.addBoard(boardDTO);
		return;
	}
	
	@Override
	public void addBoard2(BoardDTO boardDTO) {
		boardDAO.addBoard2(boardDTO);
		return;
	}

	@Override
	public BoardDTO getBoardDetail(BoardDTO boardDTO) {
		return boardDAO.getBoardDetail(boardDTO);
	}

	
}
