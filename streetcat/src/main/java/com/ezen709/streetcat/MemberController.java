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
			
			String msg = "���̵�� ��й�ȣ�� Ȯ���� �ּ���.";	
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
	//�̸��� ���� ����
	 @Inject    //���񽺸� ȣ���ϱ� ���ؼ� �������� ����
	    JavaMailSender mailSender;     //���� ���񽺸� ����ϱ� ���� �������� ������.
	    MemberService memberservice; //���񽺸� ȣ���ϱ� ���� �������� ����
	   
	    //�α��� ���� ����
	    private static final Logger logger=
	    LoggerFactory.getLogger(MemberController.class);
	    private static final String String = null;
	    
	 // mailSending �ڵ�
        @RequestMapping( value = "/auth.do" , method=RequestMethod.POST )
        public ModelAndView mailSending(HttpServletRequest request, String email, HttpServletResponse response_email) throws IOException {
 
            Random r = new Random();
            int dice = r.nextInt(4589362) + 49311; //�̸��Ϸ� �޴� �����ڵ� �κ� (����)
            
            String setfrom = "streetcat.709@gamil.com";
            String tomail = request.getParameter("email"); // �޴� ��� �̸���
            String title = "ȸ������ ���� �̸��� �Դϴ�."; // ����
            String content =
            
            System.getProperty("line.separator")+ //���پ� �ٰ����� �α����� �ۼ�
            
            System.getProperty("line.separator")+
                    
            "�ȳ��ϼ��� ȸ���� ���� Ȩ�������� ã���ּż� �����մϴ�"
            
            +System.getProperty("line.separator")+
            
            System.getProperty("line.separator")+
    
            " ������ȣ�� " +dice+ " �Դϴ�. "
            
            +System.getProperty("line.separator")+
            
            System.getProperty("line.separator")+
            
            "������ ������ȣ�� Ȩ�������� �Է��� �ֽø� �������� �Ѿ�ϴ�."; // ����
            
            
            try {
                MimeMessage message = mailSender.createMimeMessage();
                MimeMessageHelper messageHelper = new MimeMessageHelper(message,
                        true, "UTF-8");
 
                messageHelper.setFrom(setfrom); // �����»�� �����ϸ� �����۵��� ����
                messageHelper.setTo(tomail); // �޴»�� �̸���
                messageHelper.setSubject(title); // ���������� ������ �����ϴ�
                messageHelper.setText(content); // ���� ����
                
                mailSender.send(message);
            } catch (Exception e) {
                System.out.println(e);
            }
            
            ModelAndView mv = new ModelAndView();    //ModelAndView�� ���� �������� �����ϰ�, ���� ���� �����Ѵ�.
            mv.setViewName("/signUp/email_identify");     //�����̸�
            mv.addObject("dice", dice);
            mv.addObject("email",tomail);
            System.out.println("mv : "+mv);
 
            response_email.setContentType("text/html; charset=UTF-8");
            PrintWriter out_email = response_email.getWriter();
            out_email.println("<script>alert('�̸����� �߼۵Ǿ����ϴ�. ������ȣ�� �Է����ּ���.');</script>");
            out_email.flush();
            
            
            return mv;
            
        }
    
    //�̸��� ���� ������ ���� �޼ҵ�
    @RequestMapping("/email.do")
    public String email() {
        return "signUp/email";
    }
    
    
    //�̸��Ϸ� ���� ������ȣ�� �Է��ϰ� ���� ��ư�� ������ ���εǴ� �޼ҵ�.
    //���� �Է��� ������ȣ�� ���Ϸ� �Է��� ������ȣ�� �´��� Ȯ���ؼ� ������ ȸ������ �������� �Ѿ��,
    //Ʋ���� �ٽ� ���� �������� ���ƿ��� �޼ҵ�
    @RequestMapping(value = "emil_injeung.do{dice}", method = RequestMethod.POST)
    public ModelAndView join_injeung(HttpServletRequest req,String email_identify, @PathVariable String dice, HttpServletResponse response_equals) throws IOException {
   
        System.out.println("������ : email_identify : "+email_identify);
        
        System.out.println("������ : dice : "+dice);
        
        
        //�������̵��� �ڷḦ ���ÿ� �ϱ����� ModelAndView�� ����ؼ� �̵��� �������� �ڷḦ ����
         
        ModelAndView mv = new ModelAndView();
        
        mv.setViewName("signUp/signUp");
        
        mv.addObject("e_mail",email_identify);
        String email = req.getParameter("email");
        if (email_identify.equals(dice)) {
            
            //������ȣ�� ��ġ�� ��� ������ȣ�� �´ٴ� â�� ����ϰ� ȸ������â���� �̵���
            
            mv.setViewName("signUp/signUp");
            
            mv.addObject("email",email);
            
            //���� ������ȣ�� ���ٸ� �̸����� ȸ������ �������� ���� �Ѱܼ� �̸�����
            //�ѹ��� �Է��� �ʿ䰡 ���� �Ѵ�.
            
            response_equals.setContentType("text/html; charset=UTF-8");
            PrintWriter out_equals = response_equals.getWriter();
            out_equals.println("<script>alert('������ȣ�� ��ġ�Ͽ����ϴ�. ȸ������â���� �̵��մϴ�.');</script>");
            out_equals.flush();
    
            return mv;
            
            
        }else if (email_identify != dice) {
            
            
            ModelAndView mv2 = new ModelAndView(); 
            
            mv2.setViewName("signUp/email_identify");
            
            response_equals.setContentType("text/html; charset=UTF-8");
            PrintWriter out_equals = response_equals.getWriter();
            out_equals.println("<script>alert('������ȣ�� ��ġ�����ʽ��ϴ�. ������ȣ�� �ٽ� �Է����ּ���.'); history.go(-1);</script>");
            out_equals.flush();
            
    
            return mv2;
            
        }    
    
        return mv;
        
    }
	    
	    
}
