package com.spring.innoblems.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.innoblems.dao.UserDAO;
import com.spring.innoblems.dto.SkillDTO;
import com.spring.innoblems.dto.UserDTO;

@Service
public class UserServiceImpl  implements UserService {

	@Autowired
	UserDAO userDAO;

	@Override
	public int addUser(UserDTO userDTO) {
		return userDAO.addUser(userDTO);
	}

	@Override
	public void addUserSkill(List skillList) {
		for(int i = 0; i<skillList.size(); i++) {
			SkillDTO skillDTO = (SkillDTO) skillList.get(i);
			userDAO.addUserSkill(skillDTO);
		}
	}

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
		
		List userList = userDAO.getUserList(selectMap);
		
		int total = userDAO.getUserTotal(selectMap);
		
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
		
		return resultMap;
	}

	@Override
	public void delUser(List list) {
		userDAO.delUser(list);
		return;
	}

	@Override
	public UserDTO getUserDetail(UserDTO userDTO) {
		return userDAO.getUserDetail(userDTO);
	}

	@Override
	public int saveUser(UserDTO userDTO) {
		return userDAO.saveUser(userDTO);
	}
}