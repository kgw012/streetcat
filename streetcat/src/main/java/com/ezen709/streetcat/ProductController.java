package com.ezen709.streetcat;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ezen709.streetcat.model.CatBoardDTO;
import com.ezen709.streetcat.model.CatBoardLikeDTO;
import com.ezen709.streetcat.model.MemberDTO;
import com.ezen709.streetcat.model.ProdLikeDTO;
import com.ezen709.streetcat.model.ProductDTO;
import com.ezen709.streetcat.service.ProductMapper;

@Controller
public class ProductController {

		
	
		@Autowired
		private ProductMapper productMapper;
		
		@RequestMapping("/product_list.do")
		public ModelAndView productList(HttpServletRequest req) {
			
			
			String pageNum = req.getParameter("pageNum");
			if (pageNum == null) {
				pageNum = "1";
			}
			int pageSize = 5;
			int currentPage = Integer.parseInt(pageNum);
			int startRow = pageSize * currentPage - (pageSize - 1);
			int endRow = pageSize * currentPage;
			int count = productMapper.getCountProd();
			if (endRow>count) endRow = count;
			
			int startNum = count - ((currentPage-1) * pageSize);
			int pageBlock = 3;
			int pageCount = count/pageSize + (count%pageSize == 0 ? 0 : 1);
			int startPage = (currentPage - 1)/pageBlock * pageBlock + 1;
			int endPage = startPage + pageBlock - 1;
			if (endPage>pageCount) endPage = pageCount;
			
			List<ProductDTO> listProduct = productMapper.listProduct(startRow, endRow);
		
			String uploadPath = req.getSession().getServletContext().getRealPath("/") + "resources/upload/product/";
			ModelAndView mav = new ModelAndView();
			mav.setViewName("product/product_list");
			mav.addObject("count", count);
			mav.addObject("startNum", startNum);
			mav.addObject("pageCount", pageCount);
			mav.addObject("startPage", startPage);
			mav.addObject("endPage", endPage);
			mav.addObject("pageBlock", pageBlock);
			mav.addObject("listProduct", listProduct);
			mav.addObject("uploadPath", uploadPath);
	
			
			HttpSession session = req.getSession();
		
			
			mav.addObject("session", session);
			
			return mav;
		}
		
		@RequestMapping("/product_write.do")
			public ModelAndView productWrite(HttpSession session) {
			
		
			ModelAndView mav = new ModelAndView("product/product_write");
	
			
						
			return mav;
		}
		@RequestMapping("/product_write_ok.do")
		public String fileUpload_ok(HttpServletRequest req,@ModelAttribute ProductDTO dto,HttpSession session)  {
			String filename="";
			int filesize =0;
			String filename2="";
			int filesize2 =0;
			
			MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
			MultipartFile file = mr.getFile("image1_file");
			MultipartFile file2 = mr.getFile("image2_file");

			String uploadPath = req.getSession().getServletContext().getRealPath("/") + "resources/upload/product/";
			File target = new File(uploadPath, file.getOriginalFilename());
			File target2 = new File(uploadPath, file2.getOriginalFilename());
			int res = 0;
			if(file.getSize() > 0 || file2.getSize() >0) {
				try {
					file.transferTo(target);
					file2.transferTo(target2);
					filename =file.getOriginalFilename();
					filesize = (int)file.getSize();
					filename2 =file2.getOriginalFilename();
					filesize2 = (int)file2.getSize();
				
				} catch (IOException e) {
					e.printStackTrace();
				}	
			}
		      dto.setImage1(file.getOriginalFilename());
		      dto.setImage2(file2.getOriginalFilename());
		      dto.setPlike(0);
		  //    int unum = Integer.parseInt(req.getParameter("unum"));
		  	int unum =(int)session.getAttribute("unum");
		      dto.setUnum(unum);
		     
		      res = productMapper.insertProduct(dto);
			return "redirect:product_list.do";
		}		
	
	
		
		@RequestMapping("/product_content.do")
		public ModelAndView content(HttpServletRequest req) {
			
			int pnum = Integer.parseInt(req.getParameter("pnum"));
		
			ProductDTO dto = productMapper.getProduct(pnum);
			ModelAndView mav = new ModelAndView("product/product_content", "getProduct", dto);
		
			HttpSession session = req.getSession();
			int unum= 0;
			if(session.getAttribute("unum")==null) {
				 unum = 0;
			}else {
				unum =(int)session.getAttribute("unum");
			}
			  int count_like = productMapper.getProdLike(pnum, unum);
			  String like = null;
			  if(count_like ==0	) {
				  like ="unlike";
			  }else {
				  like="like";
			  }
			 
			String uploadPath = req.getSession().getServletContext().getRealPath("/") + "resources/upload/product/";
			mav.addObject("uploadPath",uploadPath);
			mav.addObject("like", like);
			return mav;
		}
		@RequestMapping(value="/product_update.do",method=RequestMethod.GET)
		public ModelAndView updateForm(@RequestParam int pnum)	{
			ProductDTO dto = productMapper.getProduct(pnum);
			ModelAndView mav = new ModelAndView("product/product_update","getProduct", dto);
			
			return mav;
		}
		
		@RequestMapping(value="/product_update.do",method=RequestMethod.POST)
		public String updatePro(@RequestParam int pnum,@ModelAttribute ProductDTO dto)	{
			int res = productMapper.updateProduct(dto);
			return "redirect:product_list.do";
		}
		@RequestMapping(value="/product_delete.do",method=RequestMethod.GET)
		public String deleteForm()	{
			return "product/product_delete";
		}
		@RequestMapping(value="/product_delete.do",method=RequestMethod.POST)
		public String deletePro(@RequestParam int pnum, @RequestParam String delete)	{
			
			int res =  productMapper.deleteProduct(pnum, delete);
			return "redirect:product_list.do";
		}
	
		//추천기능
		@RequestMapping(value="/product_like.do")
		public String proudctLike(HttpServletRequest req) {
			String msg,url = null;
	        int pnum = Integer.parseInt(req.getParameter("pnum"));
	        int mbNo = Integer.parseInt(req.getParameter("mbNo"));
	       
	        int res = productMapper.plusProdLike(pnum, mbNo);
	        System.out.println("res : " + res);
	        int plike = productMapper.getProdLikeAll(pnum);
	        System.out.println("plike : " + plike);
	        if(res>0) {
			   productMapper.updateLike(pnum, plike);
				msg = "좋아요 성공 게시글로 이동합니다";
				url = "product_content.do?pnum="+pnum;
			}else {
				msg = "좋아요 실패 게시글로 이동합니다";
				url = "product_content.do?pnum="+pnum;
			}
			req.setAttribute("msg", msg);
			req.setAttribute("url", url);
			return "message";
		}
		@RequestMapping(value="/product_unLike.do")
		public String proudctUnLike(HttpServletRequest req) {
			String msg,url = null;
	        int pnum = Integer.parseInt(req.getParameter("pnum"));
	        int mbNo = Integer.parseInt(req.getParameter("mbNo"));
   
	        int res = productMapper.minusProdLike(pnum, mbNo);
	    	int plike = productMapper.getProdLikeAll(pnum);
			
	    	if(res>0) {
				productMapper.updateLike(pnum, plike);
				msg = "좋아요 취소 성공 게시글로 이동합니다";
				url = "product_content.do?pnum="+pnum;
			}else {
				msg = "좋아요 취소 실패 게시글로 이동합니다";
				url = "product_content.do?pnum="+pnum;
			}
			req.setAttribute("msg", msg);
			req.setAttribute("url", url);
			return "message";
		}
		
}
