package com.ezen709.streetcat;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ezen709.streetcat.model.LoginDTO;
import com.ezen709.streetcat.model.MemberDTO;
import com.ezen709.streetcat.service.LoginMapper;
import com.ezen709.streetcat.service.MemberMapper;

@Controller
public class MemberController {

	@Autowired
	private MemberMapper memberMapper;
	@Autowired
	private LoginMapper loginMapper;

	

	@RequestMapping(value = "/admin_list.do", method = RequestMethod.GET)
	public ModelAndView memberList(HttpServletRequest req) {
		String mode = req.getParameter("mode");
		List<MemberDTO> listMember = memberMapper.listMember();
		if (mode == null) {
			mode = "all";
		}
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/admin_list");
		mav.addObject("mode", mode);
		mav.addObject("listMember", listMember);
		return mav;
	}

	@RequestMapping(value = "/find.do", method = RequestMethod.POST)
	public ModelAndView memberList_Ok(HttpServletRequest req) {
		String mode = req.getParameter("mode");
		String search = req.getParameter("search");
		String searchString = req.getParameter("searchString");
		List<MemberDTO> listMember = memberMapper.findMember(search, searchString);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/admin_list");
		mav.addObject("mode", mode);
		mav.addObject("listMember", listMember);
		return mav;

	}

	@RequestMapping(value = "/upgrade.do", method = RequestMethod.GET)
	public ModelAndView upgradeForm(@RequestParam int unum) {
		MemberDTO dto = memberMapper.getMember(unum);
		ModelAndView mav = new ModelAndView("admin/upgrade", "getMember", dto);

		return mav;
	}

	@RequestMapping(value = "/upgrade.do", method = RequestMethod.POST)
	public String upgradePro(MemberDTO dto) {
		int res = memberMapper.upgradeMember(dto);
		return "redirect:admin_list.do";
	}

	@RequestMapping(value = "/delete.do", method = RequestMethod.GET)
	public ModelAndView deleteForm(@RequestParam int unum) {

		ModelAndView mav = new ModelAndView("admin/delete");

		return mav;
	}

	@RequestMapping(value = "/delete.do", method = RequestMethod.POST)
	public String deletePro(HttpServletRequest req) {
		int unum = Integer.parseInt(req.getParameter("unum"));
		String check = req.getParameter("check");
		int res = memberMapper.deleteMember(unum, check);
		return "redirect:admin_list.do";
	}

	@RequestMapping("/member_logout.do")
	public String logout(HttpSession session) {

		session.invalidate();
		return "redirect:home.do";
	}

	@RequestMapping("/member_login.do")
	public ModelAndView login(HttpServletRequest req) {

		String id = req.getParameter("id");
		String passwd = req.getParameter("passwd");
	
		LoginDTO dto = loginMapper.logincheck(id, passwd);
	
		String mbId = null;
		int grade = 0;
		int unum = 0;
		String gradeString = null;
		ModelAndView mav = new ModelAndView();
		
			if (dto== null || dto.getId().trim().equals("")) {
			
			String msg = "���̵�� ��й�ȣ�� Ȯ���� �ּ���.";	
			String url = "home.do";
			mav.setViewName("message");	
			mav.addObject("msg", msg);
			mav.addObject("url", url);
				return mav;

			} else if (dto.getId() != null) {

				mbId =dto.getId();
				grade = dto.getGrade();
				unum = dto.getUnum();
				if (grade == 0) {
					gradeString = "�Ϲ�ȸ��";
				} else if (grade == 1) {
					gradeString = "��ȸ��";
				} else if (grade == 2) {
					gradeString = "���ȸ��";
				} else if (grade == 3) {
					gradeString = "������";
				}
				HttpSession session = req.getSession();
				
				session.setAttribute("mbId", mbId);
				session.setAttribute("grade", gradeString);
				session.setAttribute("unum", unum);
				session.setAttribute("mbNo", unum);
				mav.setViewName("home");
				mav.addObject("session", session);
				
			}
		
		return mav;

	}

}
