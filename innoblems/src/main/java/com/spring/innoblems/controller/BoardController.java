package com.spring.innoblems.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.innoblems.aop.SHA256;
import com.spring.innoblems.dto.BoardDTO;
import com.spring.innoblems.dto.ProjectDTO;
import com.spring.innoblems.dto.SkillDTO;
import com.spring.innoblems.dto.UserDTO;
import com.spring.innoblems.service.BoardService;
import com.spring.innoblems.service.MainService;

@Controller
public class BoardController {

	@Autowired
	BoardService boardService;
	
	@Autowired
	MainService mainService;
	
	@ResponseBody
	@RequestMapping("/getBoardList")
	public Map getBoardList(HttpServletRequest request, BoardDTO boardDTO) throws Exception {
		Map selectMap = new HashMap();

		int pageNum = 1;
		int countPerPage = 5;
		
		String tmp_pageNum = request.getParameter("pageNum");
		
		if(tmp_pageNum != null) {
			try { 
				pageNum = Integer.parseInt(tmp_pageNum);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		String tmp_countPerPage = request.getParameter("countPerPage");
		
		if(tmp_countPerPage != null) {
			try { 
				countPerPage = Integer.parseInt(tmp_countPerPage);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		selectMap.put("boardDTO", boardDTO);
		selectMap.put("pageNum", pageNum);
		selectMap.put("countPerPage", countPerPage);
		
		Map boardMap = new HashMap();
		
		try {
			boardMap = boardService.getBoardList(selectMap);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("오류가 발생했습니다.");
		}
		
		return boardMap;
	}
	
	@RequestMapping("/goAddBoard")
	public String goAddBoard(Model model, HttpServletRequest request, BoardDTO boardDTO) {
		
		List codeList = mainService.getCodeList();
		
		model.addAttribute("codeList", codeList);
		
		return "addBoard";
	}
	
	@ResponseBody
	@RequestMapping("/addBoard")
	public int addBoard(HttpServletRequest request, BoardDTO boardDTO) throws Exception {
		
		try {
			boardService.addBoard(boardDTO);
			
			return 0;
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("오류가 발생했습니다.");
			
			return 1;
		}
	}
	
	@ResponseBody
	@RequestMapping("/addBoard2")
	public int addBoard2(HttpServletRequest request, BoardDTO boardDTO) throws Exception {
		
		try {
			boardService.addBoard2(boardDTO);
			
			return 0;
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("오류가 발생했습니다.");
			
			return 1;
		}
	}
	
	@RequestMapping("/getBoardDetail")
	public String getBoardDetail (HttpServletRequest request, BoardDTO boardDTO, Model model) {
		List codeList = mainService.getCodeList();
		
		boardDTO = boardService.getBoardDetail(boardDTO);
		
		model.addAttribute("codeList", codeList);
		model.addAttribute("boardDTO", boardDTO);
		
		return "boardDetail";
	}
}
