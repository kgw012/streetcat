package com.ezen709.streetcat;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ezen709.streetcat.model.CatBoardCommentDTO;
import com.ezen709.streetcat.model.CatBoardDTO;
import com.ezen709.streetcat.model.MemberDTO;
import com.ezen709.streetcat.service.MemberMapper;

@Controller
public class MyPageController {

	@Autowired
	private MemberMapper memberMapper;
	
	
	@RequestMapping(value = "/myPage.do")
	public ModelAndView go_myPage(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		//check login session
		if(session.getAttribute("unum") == null) {
			String msg = "로그인 후 이용가능한 페이지입니다.";	
			String url = "loginPage.do";
			mav.setViewName("message");	
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			return mav;
		}
		
		mav.setViewName("myPage/myPage");
		
		int unum = (int)session.getAttribute("unum");
		MemberDTO member = memberMapper.getMember(unum);
		List<CatBoardDTO> memberBoardList = memberMapper.getMemberBoardList(member.getUserId());
		int countBoard = memberBoardList.size();
		List<CatBoardCommentDTO> memberCommentList = memberMapper.getMemberCommentList(member.getUserId());
		int countComment = memberCommentList.size();
		
		mav.addObject("joindate", member.getJoindate());
		mav.addObject("countBoard", countBoard);
		mav.addObject("countComment", countComment);
		mav.addObject("memberBoardList", memberBoardList);
		mav.addObject("memberCommentList", memberCommentList);
		
		return mav;
	}
	
}