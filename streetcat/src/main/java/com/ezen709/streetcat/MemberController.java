package com.ezen709.streetcat;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ezen709.streetcat.model.MemberDTO;
import com.ezen709.streetcat.service.MemberMapper;

@Controller
public class MemberController {

	
		@Autowired
		private MemberMapper memberMapper;
		
		@RequestMapping(value="/member.do", method=RequestMethod.GET)
		public String memberInsertForm() {
			return "member/member";
		}
		
		
		
		@RequestMapping(value="/member.do", method=RequestMethod.POST)
		public String memberInsert_Ok(@ModelAttribute MemberDTO dto) {
			
			int res = memberMapper.insertMember(dto);
			return "redirect:home.do";
		}
		
		@RequestMapping(value="/list.do", method=RequestMethod.GET)
		public ModelAndView memberList(HttpServletRequest req) {
			String mode = req.getParameter("mode");
			List<MemberDTO> listMember =memberMapper.listMember();
			if(mode ==null) {
				mode = "all";
			}
			ModelAndView mav = new ModelAndView();
			mav.setViewName("member/list");
			mav.addObject("mode", mode);
			mav.addObject("listMember", listMember);
			return mav;
		}
		
		@RequestMapping(value="/find.do", method=RequestMethod.POST)
		public ModelAndView memberList_Ok(HttpServletRequest req) {
			String mode =req.getParameter("mode");
			String search = req.getParameter("search");
			String searchString = req.getParameter("searchString");
			List<MemberDTO> listMember = memberMapper.findMember(search, searchString);
			
			ModelAndView mav = new ModelAndView();
			mav.setViewName("member/list");
			mav.addObject("mode", mode);
			mav.addObject("listMember", listMember);
			return mav;
			
		}
}
