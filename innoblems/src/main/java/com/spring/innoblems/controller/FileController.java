package com.spring.innoblems.controller;

import java.io.File;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.innoblems.service.FileService;

@Controller
public class FileController {
	
	@Autowired
	FileService fileService;
	
	private String path="C:\\git\\INNOBLEMS\\innoblems\\src\\main\\webapp\\resources\\userImages";
    
    @ResponseBody
    @RequestMapping("/result")
    public String result(@RequestParam("file1") MultipartFile multi,HttpServletRequest request,HttpServletResponse response, Model model)
    {
    	System.out.println("fileupload ing");
        String url = null;
        
        try {
            String uploadpath = path;
            String originFilename = multi.getOriginalFilename();
            String extName = originFilename.substring(originFilename.lastIndexOf("."),originFilename.length());
            long size = multi.getSize();
            
            System.out.println("size = " + size);
            
            if(size <= 41943040) {
            	String saveFileName = genSaveFileName(extName);
                
                if(!multi.isEmpty())
                {
                    File file = new File(uploadpath, saveFileName);
                    multi.transferTo(file);
                    
                    return saveFileName;
                }
            } else {
            	return "-1";
            }
            
        }catch(Exception e)
        {
            System.out.println(e);
        }
        return "redirect:form";
    }
    
    // 현재 시간을 기준으로 파일 이름 생성
    private String genSaveFileName(String extName) {
        String fileName = "";
        
        Calendar calendar = Calendar.getInstance();
        fileName += calendar.get(Calendar.YEAR);
        fileName += calendar.get(Calendar.MONTH);
        fileName += calendar.get(Calendar.DATE);
        fileName += calendar.get(Calendar.HOUR);
        fileName += calendar.get(Calendar.MINUTE);
        fileName += calendar.get(Calendar.SECOND);
        fileName += calendar.get(Calendar.MILLISECOND);
        fileName += extName;
        
        return fileName;
    }
}
