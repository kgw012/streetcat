package com.ezen709.streetcat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ezen709.streetcat.model.MemberDTO;
import com.ezen709.streetcat.service.MemberMapper;


@Controller
public class SignUpController {

	
		@Autowired
		MemberMapper memberMapper;
		
		@RequestMapping(value = "/signUpPage.do")
		public String signUpPage() {
			
			return "signUp/signUp";
		}
		/*
		@RequestMapping(value= "/loginPage.do")
		public String loginPage() {
			
			return "signUp/loginPage";
		}*/
		
		//produces는 ajax가 데이터 넘겨받을때 깨짐 방지
		@RequestMapping(value = "/idCheck.do",method = RequestMethod.GET, produces = "application/text; charset=utf8")
		@ResponseBody
		public String idCheck(HttpServletRequest request) {
			
			String userId = request.getParameter("userId");
			int result=memberMapper.idCheck(userId);
			return Integer.toString(result);
		}
		
	
		@RequestMapping(value = "/signUp.do")
		public String signUp(MemberDTO dto) {
			
			memberMapper.signUp(dto);
			
			return "home";
		}
		
	}