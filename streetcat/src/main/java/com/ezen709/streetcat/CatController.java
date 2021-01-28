package com.ezen709.streetcat;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ezen709.streetcat.model.CatDTO;
import com.ezen709.streetcat.model.MemberDTO;
import com.ezen709.streetcat.service.CatMapper;
import com.ezen709.streetcat.service.MemberMapper;

@Controller
public class CatController {

	@Autowired
	private CatMapper catMapper;
	
	@Autowired
	private MemberMapper memberMapper;
	
	@RequestMapping(value = "/cat_list.do", method = RequestMethod.GET)
	public ModelAndView go_catList() {
		List<CatDTO> catList = catMapper.getCatList();
		ModelAndView mav = new ModelAndView("cat/cat_list");
		mav.addObject("catList", catList);
		return mav;
	}
	
	@RequestMapping(value = "/cat_list.do", method = RequestMethod.POST)
	public ModelAndView findCat(@RequestParam String searchString, @RequestParam String search) {
		ModelAndView mav = new ModelAndView("cat/cat_list");
		List<CatDTO> catList = null;
		if(searchString.equals("findByLocation")) {
			String[] s = search.split(",");
			double lat = Double.parseDouble(s[0]);
			double lon = Double.parseDouble(s[1]);
			catList = catMapper.findCatListByLocation(lat, lon);
		}else {
			catList = catMapper.findCatList(searchString, search);
		}
		mav.addObject("catList", catList);
		return mav;
	}
	
	@RequestMapping("/searchCat.do")
	public String view_searchCat() {
		return "cat/searchCat";
	}
	
	@RequestMapping(value = "/cat_insert.do", method = RequestMethod.POST)
	public ModelAndView insert_cat(@RequestParam int unum) {
		ModelAndView mav = new ModelAndView("cat/cat_insert");
		mav.addObject("unum", unum);
		MemberDTO member = memberMapper.getMember(unum);
		mav.addObject("writer", member.getUserId());
		return mav;
	}
	
	@RequestMapping(value = "/cat_insert_ok.do", method = RequestMethod.POST)
	public String insert_cat_ok(HttpServletRequest req, @ModelAttribute CatDTO dto, BindingResult result) {
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		MultipartFile file = mr.getFile("image_file");
		
		String uploadPath =  req.getSession().getServletContext().getRealPath("/") + "resources/upload/cat/";
		String filename = dto.getCnum() + "_" + file.getOriginalFilename();
		
		if(file!=null) {
			File target = new File(uploadPath, filename);
			try {
				file.transferTo(target);
				int filesize = (int)file.getSize();
				dto.setImage(filename);
			}catch (IOException e) {
				e.printStackTrace();
			}
	    }
		
		int res = catMapper.insertCat(dto);
		
		return "redirect:cat_list.do";
	}
	
	@RequestMapping(value = "/cat_content.do")
	public ModelAndView cat_content(@RequestParam String cnum) {
		CatDTO dto = catMapper.getCatByCnum(Integer.parseInt(cnum));
		ModelAndView mav = new ModelAndView("cat/cat_content");
		MemberDTO member = memberMapper.getMember(dto.getUnum());
		mav.addObject("getCat", dto);
		mav.addObject("writer", member.getUserId());
		return mav;
	}
	
	@RequestMapping(value = "/cat_edit.do")
	public ModelAndView cat_edit(@RequestParam int unum, @RequestParam int cnum) {
		MemberDTO member = memberMapper.getMember(unum);
		ModelAndView mav = new ModelAndView("cat/cat_edit");
		CatDTO cat = catMapper.getCatByCnum(cnum);
		mav.addObject("unum", unum);
		mav.addObject("cat", cat);
		mav.addObject("writer", member.getUserId());
		return mav;
	}
	
	@RequestMapping(value = "/cat_edit_ok.do")
	public String cat_edit_ok(HttpServletRequest req, @ModelAttribute CatDTO dto, BindingResult result) {
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		MultipartFile file = mr.getFile("image_file");

		String uploadPath =  req.getSession().getServletContext().getRealPath("/") + "resources/upload/cat/";
		String filename = dto.getCnum() + "_" + file.getOriginalFilename();
		
		if(!file.isEmpty()) {
			File target = new File(uploadPath, filename);
			try {
				file.transferTo(target);
				int filesize = (int)file.getSize();
				dto.setImage(filename);
			}catch (IOException e) {
				e.printStackTrace();
			}
	    }
		
		int res = catMapper.editCat(dto);
		
		return "redirect:cat_list.do";
	}
	
	@RequestMapping(value = "/cat_delete.do")
	public String cat_delete(@RequestParam int cnum) {
		int res = catMapper.deleteCat(cnum);
		return "redirect:cat_list.do";
	}
	
}
