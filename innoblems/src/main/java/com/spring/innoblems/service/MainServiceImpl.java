package com.spring.innoblems.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.innoblems.dao.MainDAO;
import com.spring.innoblems.dto.UserDTO;

@Service
public class MainServiceImpl implements MainService {
	
	@Autowired
	MainDAO mainDAO;
	
	@Override
	public Map getUserList(Map selectMap) {
		Map resultMap = new HashMap();
		
		int pageNum = (Integer) selectMap.get("pageNum");
		int countPerPage = (Integer) selectMap.get("countPerPage");
		
		int startNum = 0;
		int endNum = 0;
		
		startNum = (pageNum-1)*countPerPage+1;
		endNum = pageNum*countPerPage;
		
		selectMap.put("startNum", startNum);
		selectMap.put("endNum", endNum);
		
		List userList = mainDAO.getUserList(selectMap);
		
		int total = mainDAO.getUserTotal(selectMap);
		
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
		resultMap.put("userList", userList);
		resultMap.put("pageNum", pageNum);
		
		System.out.println("startNum" + startNum);
		System.out.println("endNum" + endNum);
		System.out.println("total" + total);
		
		
		
		
		for(int i = 0; i<userList.size(); i++) {
			if(i == 0) {
				System.out.println("start");
			}
			System.out.println(userList.get(i).toString());
			if(i==(userList.size()-1)) {
				System.out.println("end");
			}
		}
		
		return resultMap;
	}

	@Override
	public List getCodeList() {
		return mainDAO.getCodeList();
	}

	@Override
	public void delUser(List list) {
		mainDAO.delUser(list);
		return;
	}

	
	
}
