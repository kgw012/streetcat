package com.ezen709.streetcat;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Random;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ezen709.streetcat.model.LoginDTO;
import com.ezen709.streetcat.model.MemberDTO;
import com.ezen709.streetcat.model.MessageDTO;
import com.ezen709.streetcat.service.LoginMapper;
import com.ezen709.streetcat.service.MemberMapper;
import com.ezen709.streetcat.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	private MemberMapper memberMapper;
	@Autowired
	private LoginMapper loginMapper;

	@RequestMapping(value = "/chatting.do")
	public String chatting() {
		return "chatting";
	}
	@RequestMapping(value = "/messageBox.do")
	public String messageBox(HttpServletRequest req,HttpSession session) {
		String userId = (String)session.getAttribute("mbId");
		List<MessageDTO> message = memberMapper.getMessage(userId);
		req.setAttribute("getMessage", message);
		return "message/messageBox";
	}
	@RequestMapping(value = "/messageSendBox.do")
	public String messageSendBox(HttpServletRequest req,HttpSession session) {
		String userId = (String)session.getAttribute("mbId");
		List<MessageDTO> message = memberMapper.getSendMessage(userId);
		req.setAttribute("getMessage", message);
		return "message/messageSendBox";
	}
	@RequestMapping(value = "/messageWrite.do")
	public String messageWrite(HttpServletRequest req) {
		if(req.getParameter("sendId")!=null) {
			req.setAttribute("sendId",req.getParameter("sendId"));
		}
		return "message/messageWrite";
	}
	@RequestMapping(value = "/messageReceiveDelete.do")
	public String messageReceiveDelete(HttpServletRequest req,HttpSession session) {
		String check = "";
		int mnum = 0;
		for(int i = 1;i<11;++i) {
			check=new String("checkbox"+i);
			if(req.getParameter(check)!=null) {
				mnum = Integer.parseInt(req.getParameter(check));
				memberMapper.receiveDelete(mnum);
				}
		}
		String userId = (String)session.getAttribute("mbId");
		List<MessageDTO> message = memberMapper.getMessage(userId);
		req.setAttribute("getMessage", message);
		return "message/messageBox";
	}
	@RequestMapping(value = "/messageSendDelete.do")
	public String messageSendDelete(HttpServletRequest req,HttpSession session) {
		String check = "";
		int mnum = 0;
		for(int i = 1;i<11;++i) {
			check=new String("checkbox"+i);
			if(req.getParameter(check)!=null) {
			mnum = Integer.parseInt(req.getParameter(check));
			memberMapper.sendDelete(mnum);
			}	
		}
		String userId = (String)session.getAttribute("mbId");
		List<MessageDTO> message = memberMapper.getSendMessage(userId);
		req.setAttribute("getMessage", message);
		return "message/messageSendBox";
	}
	@RequestMapping(value = "/messageSend.do")
	public String messageSend(HttpServletRequest req,HttpSession session,@ModelAttribute MessageDTO dto) {
		String userId = (String)session.getAttribute("mbId");
		int num = (int) session.getAttribute("mbNo");
		MemberDTO dto2 = memberMapper.getMember(num);
		dto.setSendId(userId);
		dto.setSendName(dto2.getName());
		int res = memberMapper.sendMessage(dto);
		List<MessageDTO> message = memberMapper.getSendMessage(userId);
		req.setAttribute("getMessage", message);
		return "message/messageSendBox";
	}
	@RequestMapping(value = "/messageContent.do")
	public String messageContent(HttpServletRequest req,HttpSession session,@ModelAttribute MessageDTO dto) {
		String userId = (String)session.getAttribute("mbId");
		int mnum = Integer.parseInt(req.getParameter("mnum"));
		if(req.getParameter("type")!=null) {
		memberMapper.messageRead(mnum);}
		MessageDTO message = memberMapper.getMessageContent(mnum);
		req.setAttribute("getMessage", message);
		return "message/messageContent";
	}


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

		String userId = req.getParameter("userId");
		String passwd = req.getParameter("passwd");
	
		LoginDTO dto = loginMapper.logincheck(userId, passwd);
	
		String mbId = null;
		int grade = 0;
		int unum = 0;
		String gradeString = null;
		ModelAndView mav = new ModelAndView();
		
			if (dto== null || dto.getUserId().trim().equals("")) {
			
			String msg = "아이디와 비밀번호를 확인해 주세요.";	
			String url = "home.do";
			mav.setViewName("message");	
			mav.addObject("msg", msg);
			mav.addObject("url", url);
				return mav;

			} else if (dto.getUserId() != null) {

				mbId =dto.getUserId();
				grade = dto.getGrade();
				unum = dto.getUnum();
				if (grade == 0) {
					gradeString = "일반회원";
				} else if (grade == 1) {
					gradeString = "준회원";
				} else if (grade == 2) {
					gradeString = "우수회원";
				} else if (grade == 3) {
					gradeString = "관리자";
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
	//이메일 인증 관련
	 @Inject    //서비스를 호출하기 위해서 의존성을 주입
	    JavaMailSender mailSender;     //메일 서비스를 사용하기 위해 의존성을 주입함.
	    MemberService memberservice; //서비스를 호출하기 위해 의존성을 주입
	   
	    //로깅을 위한 변수
	    private static final Logger logger=
	    LoggerFactory.getLogger(MemberController.class);
	    private static final String String = null;
	    
	 // mailSending 코드
        @RequestMapping( value = "/auth.do" , method=RequestMethod.POST )
        public ModelAndView mailSending(HttpServletRequest request, String email, HttpServletResponse response_email) throws IOException {
 
            Random r = new Random();
            int dice = r.nextInt(4589362) + 49311; //이메일로 받는 인증코드 부분 (난수)
            
            String setfrom = "streetcat.709@gamil.com";
            String tomail = request.getParameter("email"); // 받는 사람 이메일
            String title = "회원가입 인증 이메일 입니다."; // 제목
            String content =
            
            System.getProperty("line.separator")+ //한줄씩 줄간격을 두기위해 작성
            
            System.getProperty("line.separator")+
                    
            "안녕하세요 회원님 저희 홈페이지를 찾아주셔서 감사합니다"
            
            +System.getProperty("line.separator")+
            
            System.getProperty("line.separator")+
    
            " 인증번호는 " +dice+ " 입니다. "
            
            +System.getProperty("line.separator")+
            
            System.getProperty("line.separator")+
            
            "받으신 인증번호를 홈페이지에 입력해 주시면 다음으로 넘어갑니다."; // 내용
            
            
            try {
                MimeMessage message = mailSender.createMimeMessage();
                MimeMessageHelper messageHelper = new MimeMessageHelper(message,
                        true, "UTF-8");
 
                messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
                messageHelper.setTo(tomail); // 받는사람 이메일
                messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
                messageHelper.setText(content); // 메일 내용
                
                mailSender.send(message);
            } catch (Exception e) {
                System.out.println(e);
            }
            
            ModelAndView mv = new ModelAndView();    //ModelAndView로 보낼 페이지를 지정하고, 보낼 값을 지정한다.
            mv.setViewName("/signUp/email_identify");     //뷰의이름
            mv.addObject("dice", dice);
            mv.addObject("email",tomail);
            System.out.println("mv : "+mv);
 
            response_email.setContentType("text/html; charset=UTF-8");
            PrintWriter out_email = response_email.getWriter();
            out_email.println("<script>alert('이메일이 발송되었습니다. 인증번호를 입력해주세요.');</script>");
            out_email.flush();
            
            
            return mv;
            
        }
    
    //이메일 인증 페이지 맵핑 메소드
    @RequestMapping("/email.do")
    public String email() {
        return "signUp/email";
    }
    
    
    //이메일로 받은 인증번호를 입력하고 전송 버튼을 누르면 맵핑되는 메소드.
    //내가 입력한 인증번호와 메일로 입력한 인증번호가 맞는지 확인해서 맞으면 회원가입 페이지로 넘어가고,
    //틀리면 다시 원래 페이지로 돌아오는 메소드
    @RequestMapping(value = "emil_injeung.do{dice}", method = RequestMethod.POST)
    public ModelAndView join_injeung(HttpServletRequest req,String email_identify, @PathVariable String dice, HttpServletResponse response_equals) throws IOException {
   
        System.out.println("마지막 : email_identify : "+email_identify);
        
        System.out.println("마지막 : dice : "+dice);
        
        
        //페이지이동과 자료를 동시에 하기위해 ModelAndView를 사용해서 이동할 페이지와 자료를 담음
         
        ModelAndView mv = new ModelAndView();
        
        mv.setViewName("signUp/signUp");
        
        mv.addObject("e_mail",email_identify);
        String email = req.getParameter("email");
        if (email_identify.equals(dice)) {
            
            //인증번호가 일치할 경우 인증번호가 맞다는 창을 출력하고 회원가입창으로 이동함
            
            mv.setViewName("signUp/signUp");
            
            mv.addObject("email",email);
            
            //만약 인증번호가 같다면 이메일을 회원가입 페이지로 같이 넘겨서 이메일을
            //한번더 입력할 필요가 없게 한다.
            
            response_equals.setContentType("text/html; charset=UTF-8");
            PrintWriter out_equals = response_equals.getWriter();
            out_equals.println("<script>alert('인증번호가 일치하였습니다. 회원가입창으로 이동합니다.');</script>");
            out_equals.flush();
    
            return mv;
            
            
        }else if (email_identify != dice) {
            
            
            ModelAndView mv2 = new ModelAndView(); 
            
            mv2.setViewName("signUp/email_identify");
            
            response_equals.setContentType("text/html; charset=UTF-8");
            PrintWriter out_equals = response_equals.getWriter();
            out_equals.println("<script>alert('인증번호가 일치하지않습니다. 인증번호를 다시 입력해주세요.'); history.go(-1);</script>");
            out_equals.flush();
            
    
            return mv2;
            
        }    
    
        return mv;
        
    }
	    
	    
}
