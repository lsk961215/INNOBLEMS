package com.spring.innoblems.dao;

import java.util.List;
import java.util.Map;

import com.spring.innoblems.dto.UserDTO;

public interface MainDAO {
	List getUserList(Map map);
	List getCodeList();
	int getUserTotal(Map map);
	void delUser(List list);
}
