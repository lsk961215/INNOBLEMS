package com.spring.innoblems.aop;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.spring.innoblems.controller.MainController;
import com.spring.innoblems.service.MainService;

public class Interceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession(false);
		
		String requestUrl = request.getRequestURL().toString();
		
		if(requestUrl.contains("/goLogin") || requestUrl.contains("/login") || requestUrl.contains("/resources/images") || requestUrl.contains("header")){
			
		return true;

		}
		
	    if(session == null || session.getAttribute("userDTO") == null) {
	    		response.sendRedirect("goLogin");
	    		return false;
	    }
	    
	    return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

}
