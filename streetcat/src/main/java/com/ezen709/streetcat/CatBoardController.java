package com.ezen709.streetcat;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ezen709.streetcat.model.CatBoardCommentDTO;
import com.ezen709.streetcat.model.CatBoardDTO;
import com.ezen709.streetcat.model.CatBoardLikeDTO;
import com.ezen709.streetcat.model.CatDTO;
import com.ezen709.streetcat.model.FindCatBoardDTO;
import com.ezen709.streetcat.service.CatBoardMapper;

@Controller
public class CatBoardController {
	
	@Autowired
	private CatBoardMapper catBoardMapper;
	
	@RequestMapping("/home.do")
	public String index() {
		return "home";
	}
	@RequestMapping("/cat_board.do")
	public ModelAndView catBoard(HttpServletRequest req) {
		String pageNum = req.getParameter("pageNum");
		
		if (pageNum == null) {
			pageNum = "1";
		}
		int pageSize = 12;
		int currentPage = Integer.parseInt(pageNum);
		int startRow = pageSize * currentPage - (pageSize - 1);
		int endRow = pageSize * currentPage;
		int count = catBoardMapper.getCount();//boardDAO.getCount();
		if (endRow>count) endRow = count;
		List<CatBoardDTO> listBoard = catBoardMapper.cat_listBoard(startRow, endRow);//boardDAO.listBoard(startRow, endRow);
		int startNum = count - ((currentPage-1) * pageSize);
		int pageBlock = 3;
		int pageCount = count/pageSize + (count%pageSize == 0 ? 0 : 1);
		int startPage = (currentPage - 1)/pageBlock * pageBlock + 1;
		int endPage = startPage + pageBlock - 1;
		if (endPage>pageCount) endPage = pageCount;
		
		ModelAndView mav = new ModelAndView("cat_board/cat_board");
		
		String uploadPath = req.getSession().getServletContext().getRealPath("/") + "resources/upload/catBoard/";
		mav.addObject("upPath",uploadPath);
		mav.addObject("count", count);
		mav.addObject("startNum", startNum);
		mav.addObject("pageCount", pageCount);
		mav.addObject("startPage", startPage);
		mav.addObject("endPage", endPage);
		mav.addObject("pageBlock", pageBlock);
		mav.addObject("cat_listBoard", listBoard);
		return mav;
	}
	@RequestMapping(value="/cat_board_write.do")
	public String catBoardWrite(HttpServletRequest req) {
		if(req.getParameter("cnum")!=null) {
        int cnum = Integer.parseInt(req.getParameter("cnum"));
        CatDTO getCat = catBoardMapper.getCat(cnum);
        req.setAttribute("getCat", getCat);}
		return "cat_board/cat_board_write";
	}
	@RequestMapping(value="/cat_board_write_ok.do")
	public String catBoardWriteOk(HttpServletRequest req, @ModelAttribute CatBoardDTO dto, BindingResult result) {
		int filesize=0;
		String filename ;
		
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		MultipartFile file1 = mr.getFile("image1");
		MultipartFile file2 = mr.getFile("image2");
		MultipartFile file3 = mr.getFile("image3");
		MultipartFile file4 = mr.getFile("image4");
		MultipartFile file5 = mr.getFile("image5");

		String uploadPath = req.getSession().getServletContext().getRealPath("/") + "resources/upload/catBoard/";
		
		if(file1!=null) {
			File target1 = new File(uploadPath,file1.getOriginalFilename());
				try {
					file1.transferTo(target1);
					filename = file1.getOriginalFilename();
					filesize = (int)file1.getSize();
					dto.setImage1(filename);
				}catch (IOException e) {
				e.printStackTrace();
				}
	    }
		if(file2!=null) {
			File target2 = new File(uploadPath,file2.getOriginalFilename());
			try {
				file2.transferTo(target2);
				filename = file2.getOriginalFilename();
				filesize = (int)file2.getSize();
				dto.setImage2(filename);
			}catch (IOException e) {
			e.printStackTrace();
			}
    }
		if(file3!=null) {
			File target3 = new File(uploadPath,file3.getOriginalFilename());
			try {
				file3.transferTo(target3);
				filename = file3.getOriginalFilename();
				filesize = (int)file3.getSize();
				dto.setImage3(filename);
			}catch (IOException e) {
			e.printStackTrace();
			}
    }
		if(file4!=null) {
			File target4 = new File(uploadPath,file4.getOriginalFilename());
			try {
				file4.transferTo(target4);
				filename = file4.getOriginalFilename();
				filesize = (int)file4.getSize();
				dto.setImage4(filename);
			}catch (IOException e) {
			e.printStackTrace();
			}
    }
		if(file5!=null) {
			File target5 = new File(uploadPath,file5.getOriginalFilename());
			try {
				file5.transferTo(target5);
				filename = file5.getOriginalFilename();
				filesize = (int)file5.getSize();
				dto.setImage5(filename);
			}catch (IOException e) {
			e.printStackTrace();
			}
    }

		String msg = null;
		String url = null;
		if(mr.getParameter("cnum").equals("")) {
			dto.setCnum(0);	
		}else {
		dto.setCnum(Integer.parseInt(mr.getParameter("cnum")));}
		dto.setIp(req.getRemoteAddr());
		int res = catBoardMapper.insertBoard(dto);
		if(res>0) {
		    msg = "글쓰기 성공 목록 페이지로 이동합니다";
			url = "cat_board.do";
		}else {
			msg = "글쓰기 실패 목록 페이지로 이동합니다";
			url = "cat_board.do";
		}
		req.setAttribute("msg", msg);
		req.setAttribute("url", url);
		return "message";
	}
	
	@RequestMapping(value="/cat_find.do")
	public String catFind() {
		return "cat_board/cat_find";
	}
	@RequestMapping(value="/cat_find_ok.do")
	public ModelAndView catFindOk(HttpServletRequest req) {
		String location = (String)req.getParameter("location");
		List<CatDTO> listCat = catBoardMapper.cat_list(location);
		ModelAndView mav = new ModelAndView("cat_board/cat_find");

		String uploadPath = req.getSession().getServletContext().getRealPath("/") + "resources/upload/catBoard/";
		mav.addObject("upPath",uploadPath);
		mav.addObject("location",location);
		mav.addObject("cat_list",listCat);
	    System.out.print(location);
		return mav;
	}
	@RequestMapping(value="/cat_board_content.do")
	public ModelAndView catBoardContent(HttpServletRequest req,HttpSession session) {
        String pageNum = req.getParameter("pageNum");
  
		if (pageNum == null) {
			pageNum = "1";
		}
		String type = req.getParameter("type");
		if(req.getParameter("type")==null) {
			type="now";
		}
		int bnumCount = catBoardMapper.getCount();
		int bnum = Integer.parseInt(req.getParameter("bnum"));
		
		if(type.equals("next")) {
			bnum = catBoardMapper.nextBoard(bnum);
			
		}else if(type.equals("before")) {
			bnum = catBoardMapper.beforeBoard(bnum);
		}
		List<CatBoardLikeDTO> likeList = catBoardMapper.likeList(bnum);
		int count = catBoardMapper.getCommentCount(bnum);
		ModelAndView mav = new ModelAndView("cat_board/cat_board_content");
		int pageSize = 12;
		int currentPage = Integer.parseInt(pageNum);
		int startRow = pageSize * currentPage - (pageSize - 1);
		int endRow = pageSize * currentPage;		
		
		CatBoardDTO getBoard = catBoardMapper.getBoard(bnum);
		List<CatBoardCommentDTO> boardComment = catBoardMapper.boardComment(bnum,startRow,endRow);
		if (endRow>count) endRow = count;
		int startNum = count - ((currentPage-1) * pageSize);
		int pageBlock = 3;
		int pageCount = count/pageSize + (count%pageSize == 0 ? 0 : 1);
		int startPage = (currentPage - 1)/pageBlock * pageBlock + 1;
		int endPage = startPage + pageBlock - 1;
		if (endPage>pageCount) endPage = pageCount;

		String uploadPath = req.getSession().getServletContext().getRealPath("/") + "resources/upload/catBoard/";
		mav.addObject("upPath",uploadPath);
		mav.addObject("count", count);
		mav.addObject("startNum", startNum);
		mav.addObject("pageCount", pageCount);
		mav.addObject("startPage", startPage);
		mav.addObject("endPage", endPage);
		mav.addObject("pageBlock", pageBlock);
		mav.addObject("getBoard",getBoard);
		mav.addObject("boardComment",boardComment);
		mav.addObject("likeList",likeList);
		String id = (String)session.getAttribute("mbId");
		String like = "like";
		int likeCount = 0;
		for(CatBoardLikeDTO dto: likeList) {
			likeCount++;
			if(dto.getUserId().equals(id)) {
				like="unlike";
			}
		}
		catBoardMapper.plusReadCount(bnum);
		mav.addObject("likeCount",likeCount);
		mav.addObject("like",like);
		return mav;
	}
	
	@RequestMapping(value="/cat_board_comment_write.do")
	public String catBoardComentWrite(HttpServletRequest req,@ModelAttribute CatBoardCommentDTO dto, BindingResult result) {
		String msg,url = null;
		if (result.hasErrors()) {
			dto.setComment_num(0);
			dto.setRe_step(0);
			dto.setRe_level(0);
		}
        int bnum = Integer.parseInt(req.getParameter("bnum"));
        dto.setBnum(bnum);
        int res = catBoardMapper.insertComment(dto);
        String type = (String)req.getParameter("type");
		if(res>0) {
		    msg = "댓글쓰기 성공 글상세페이지로 이동합니다";
		    if(type.equals("popup")) {
		    	url= "popup";
		    }else {
			url = "cat_board_content.do?type=now&bnum="+bnum;}
		}else {
			msg = "댓글쓰기 실패 글상세 페이지로 이동합니다";
			if(type.equals("popup")) {
		    	url= "popup";
		    }else {
			url = "cat_board_content.do?type=now&bnum="+bnum;}
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("url", url);
		return "message";
	}
	@RequestMapping(value="/reComment.do")
	public String reComment(HttpServletRequest req) {
		int num = Integer.parseInt(req.getParameter("comment_num"));
		CatBoardCommentDTO getComment = catBoardMapper.getComment(num);
		req.setAttribute("getComment", getComment);
		return "cat_board/reComment";
	}
	@RequestMapping(value="/cat_board_like.do")
	public String catBoardLike(HttpServletRequest req,@ModelAttribute CatBoardLikeDTO dto) {
		String msg,url = null;
        int res = catBoardMapper.boardLike(dto);
		if(res>0) {
		    msg = "추천 성공 게시글로 이동합니다";
			url = "cat_board_content.do?bnum="+dto.getBnum();
		}else {
			msg = "추천 실패 게시글로 이동합니다";
			url = "cat_board_content.do?bnum="+dto.getBnum();
		}
		req.setAttribute("msg", msg);
		req.setAttribute("url", url);
		return "message";
	}
	@RequestMapping(value="/cat_board_unLike.do")
	public String catBoardUnLike(HttpServletRequest req,@ModelAttribute CatBoardLikeDTO dto) {
		String msg,url = null;
        int res = catBoardMapper.boardUnLike(dto);
		if(res>0) {
		    msg = "추천 취소! 게시글로 이동합니다";
			url = "cat_board_content.do?bnum="+dto.getBnum();
		}else {
			msg = "추천 실패 게시글로 이동합니다";
			url = "cat_board_content.do?bnum="+dto.getBnum();
		}
		req.setAttribute("msg", msg);
		req.setAttribute("url", url);
		
		return "message";
	}
	@RequestMapping(value="/cat_board_delete.do")
	public String catBoardDelete(HttpServletRequest req) {
		String msg,url = null;
		int bnum = Integer.parseInt(req.getParameter("bnum"));
		catBoardMapper.boardLikeDelete(bnum);
		int res =catBoardMapper.boardDelete(bnum);
		if(res>0) {
		    msg = "글삭제 성공 게시판페이지로 이동합니다";
			url = "cat_board.do";
		}else {
			msg = "글삭제 실패 게시판페이지로 이동합니다";
			url = "cat_board.do";
		}
		req.setAttribute("msg", msg);
		req.setAttribute("url", url);
		return "message";
	}
	@RequestMapping(value="/cat_board_edit.do")
	public String catBoardEdit(HttpServletRequest req) {
		int bnum = Integer.parseInt(req.getParameter("bnum"));
		CatBoardDTO getBoard = catBoardMapper.getBoard(bnum);
		req.setAttribute("bnum", bnum);
		req.setAttribute("getBoard", getBoard);
		return "cat_board/cat_board_edit";
	}
	@RequestMapping(value="/cat_board_edit_ok.do")
	public String catBoardEditOk(HttpServletRequest req,@ModelAttribute CatBoardDTO dto, BindingResult result) {
		int bnum = Integer.parseInt(req.getParameter("bnum"));
		int filesize=0;
        String filename;
		
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		MultipartFile file1 = mr.getFile("image1");
		MultipartFile file2 = mr.getFile("image2");
		MultipartFile file3 = mr.getFile("image3");
		MultipartFile file4 = mr.getFile("image4");
		MultipartFile file5 = mr.getFile("image5");
		System.out.print(file1);
		CatBoardDTO getBoard = catBoardMapper.getBoard(bnum);
		dto.setImage1(getBoard.getImage1());
		dto.setImage2(getBoard.getImage2());
		dto.setImage3(getBoard.getImage3());
		dto.setImage4(getBoard.getImage4());
		dto.setImage5(getBoard.getImage5());

		String uploadPath = req.getSession().getServletContext().getRealPath("/") + "resources/upload/catBoard/";
		
		if(!file1.isEmpty()) {
			File target1 = new File(uploadPath,file1.getOriginalFilename());
				try {
					file1.transferTo(target1);
					filename = file1.getOriginalFilename();
					filesize = (int)file1.getSize();
					dto.setImage1(filename);
				}catch (IOException e) {
				e.printStackTrace();
				}
	    }
		if(!file2.isEmpty()) {
			File target2 = new File(uploadPath,file2.getOriginalFilename());
			try {
				file2.transferTo(target2);
				filename = file2.getOriginalFilename();
				filesize = (int)file2.getSize();
				dto.setImage2(filename);
			}catch (IOException e) {
			e.printStackTrace();
			}
    }
		if(!file3.isEmpty()) {
			File target3 = new File(uploadPath,file3.getOriginalFilename());
			try {
				file3.transferTo(target3);
				filename = file3.getOriginalFilename();
				filesize = (int)file3.getSize();
				dto.setImage3(filename);
			}catch (IOException e) {
			e.printStackTrace();
			}
    }
		if(!file4.isEmpty()) {
			File target4 = new File(uploadPath,file4.getOriginalFilename());
			try {
				file4.transferTo(target4);
				filename = file4.getOriginalFilename();
				filesize = (int)file4.getSize();
				dto.setImage4(filename);
			}catch (IOException e) {
			e.printStackTrace();
			}
    }
		if(!file5.isEmpty()) {
			File target5 = new File(uploadPath,file5.getOriginalFilename());
			try {
				file5.transferTo(target5);
				filename = file5.getOriginalFilename();
				filesize = (int)file5.getSize();
				dto.setImage5(filename);
			}catch (IOException e) {
			e.printStackTrace();
			}
    }
        catBoardMapper.boardEdit(dto);
		req.setAttribute("bnum", bnum);
		req.setAttribute("msg", "수정완료!");
		req.setAttribute("url", "cat_board.do");
		return "message";
	}
	@RequestMapping(value="/find_cat_board.do")
	public ModelAndView findCatBoard(HttpServletRequest req,@ModelAttribute FindCatBoardDTO dto) {
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null) {
			pageNum = "1";
		}
		int pageSize = 12;
		int currentPage = Integer.parseInt(pageNum);
		int startRow = pageSize * currentPage - (pageSize - 1);
		int endRow = pageSize * currentPage;
		dto.setStart(startRow);
		dto.setEnd(endRow);
		int count = catBoardMapper.findGetCount(dto);
		if (endRow>count) endRow = count;
		List<CatBoardDTO> listBoard = catBoardMapper.find_cat_listBoard(dto);
		int startNum = count - ((currentPage-1) * pageSize);
		int pageBlock = 3;
		int pageCount = count/pageSize + (count%pageSize == 0 ? 0 : 1);
		int startPage = (currentPage - 1)/pageBlock * pageBlock + 1;
		int endPage = startPage + pageBlock - 1;
		if (endPage>pageCount) endPage = pageCount;
		
		ModelAndView mav = new ModelAndView("cat_board/cat_board");

		String uploadPath = req.getSession().getServletContext().getRealPath("/") + "resources/upload/catBoard/";
		mav.addObject("upPath",uploadPath);
		mav.addObject("count", count);
		mav.addObject("startNum", startNum);
		mav.addObject("pageCount", pageCount);
		mav.addObject("startPage", startPage);
		mav.addObject("endPage", endPage);
		mav.addObject("pageBlock", pageBlock);
		mav.addObject("cat_listBoard", listBoard);
		return mav;
	}
	@RequestMapping(value="/image_delete.do")
	public String imageDelete(HttpServletRequest req,CatBoardDTO dto) {
		String image = req.getParameter("image");
		int bnum = Integer.parseInt(req.getParameter("bnum"));
		dto.setBnum(bnum);
		dto.setImage(image);
		catBoardMapper.imageDelete(dto);
		String url="cat_board_edit.do?bnum="+bnum;
		req.setAttribute("msg","이미지를 삭제했습니다");
		req.setAttribute("url", url);
		return "message";
	}
}

