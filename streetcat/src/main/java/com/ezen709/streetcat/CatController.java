package com.ezen709.streetcat;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ezen709.streetcat.model.CatDTO;
import com.ezen709.streetcat.service.CatMapper;

@Controller
public class CatController {

	@Autowired
	private CatMapper catMapper;
	
	@RequestMapping(value = "cat_list.do", method = RequestMethod.GET)
	public String go_catList() {
		return "cat/cat_list";
	}
	
	@RequestMapping(value = "cat_list.do", method = RequestMethod.POST)
	public ModelAndView findCat(@RequestParam String searchString, @RequestParam String search) {
		List<CatDTO> catList = catMapper.findCatList(searchString, search);
		ModelAndView mav = new ModelAndView("redirect:cat_list.do");
		mav.addObject("catList", catList);
		return mav;
	}
	
	@RequestMapping("searchCat.do")
	public String view_searchCat() {
		return "cat/searchCat";
	}
	
//	@RequestMapping("cat_insert.do")
	
}
