package com.ezen709.streetcat;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
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
import com.ezen709.streetcat.service.CatMapper;

@Controller
public class CatController {

	@Autowired
	private CatMapper catMapper;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	@RequestMapping(value = "/cat_list.do", method = RequestMethod.GET)
	public ModelAndView go_catList() {
		List<CatDTO> catList = catMapper.getCatList();
		ModelAndView mav = new ModelAndView("cat/cat_list");
		mav.addObject("catList", catList);
		mav.addObject("uploadPath", uploadPath);
		return mav;
	}
	
	@RequestMapping(value = "/cat_list.do", method = RequestMethod.POST)
	public ModelAndView findCat(@RequestParam String searchString, @RequestParam String search) {
		List<CatDTO> catList = catMapper.findCatList(searchString, search);
		ModelAndView mav = new ModelAndView("cat/cat_list");
		mav.addObject("catList", catList);
		return mav;
	}
	
	@RequestMapping("/searchCat.do")
	public String view_searchCat() {
		return "cat/searchCat";
	}
	
	@RequestMapping(value = "/cat_insert.do", method = RequestMethod.GET)
	public String insert_cat() {
		return "cat/cat_insert";
	}
	
	@RequestMapping(value = "/cat_insert_ok.do", method = RequestMethod.POST)
	public String insert_cat_ok(HttpServletRequest req, @ModelAttribute CatDTO dto, BindingResult result) {
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		MultipartFile file = mr.getFile("image_file");
		
		if(file!=null) {
			File target = new File(uploadPath, file.getOriginalFilename());
			try {
				file.transferTo(target);
				int filesize = (int)file.getSize();
				dto.setImage(file.getOriginalFilename());
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
		mav.addObject("getCat", dto);
		mav.addObject("uploadPath", uploadPath);
		return mav;
	}
	
}
