package com.ezen709.streetcat.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.mail.javamail.JavaMailSender;

import com.ezen709.streetcat.dao.MemberDAO;
import com.ezen709.streetcat.model.MemberDTO;

public class MemberServiceImpl implements MemberService {
 
    
    @Inject    
    MemberDAO memberdao; //dao�� ����ϱ� ���� �������� ����
    private JavaMailSender mailSender;
 
    
    
    @Override    //ȸ������ �޼ҵ�, Map�� dto�� ���� �ѱ�
    public void join(Map<String, Object>map,MemberDTO dto) {
        memberdao.join(map,dto);
 
    }
 
 
    @Override    //�α��� ���� �޼ҵ� (���ǿ� ���̵�� ��й�ȣ�� ����)
    public boolean loginCheck(MemberDTO dto, HttpSession session) {
        
        boolean result = memberdao.loginCheck(dto);
        if(result) {    //�α��� ����
            session.setAttribute("user_id", dto.getUserId());
            session.setAttribute("member_pass", dto.getPasswd());
            System.out.println(session.getAttribute("userId"));
            System.out.println(session.getAttribute("passwd"));
        }
        
        return result;
    }
 
    //���̵� ã��
    @Override
    public String find_idCheck(MemberDTO dto) {
        String id = memberdao.find_idCheck(dto);
        
        return id;
    }
 
    //��й�ȣ ã��
    @Override
    public String find_passCheck(MemberDTO dto) {
        String pass = memberdao.find_passCheck(dto);
        return pass;
    }
 
 
    @Override
    public void authentication(MemberDTO dto) {
        
        memberdao.authentication(dto);
    }
 
 
    @Override
    public void pass_change(Map<String, Object> map, MemberDTO dto) throws Exception {
        
        
        memberdao.pass_change(map,dto);
    }
 
 
    //�̸��� �ߺ� Ȯ��
    @Override
    public boolean email_check(String email) throws Exception{
        
        boolean result = memberdao.email_check(email);
        
        return result;
        
    }
 
    //���̵� �ߺ� Ȯ��
    @Override
    public boolean join_id_check(String userId) throws Exception {
    
        boolean result = memberdao.join_id_check(userId);
        
        return result;
    }
 
 
    //�ڽ��� �������� �� �� �ְ� �ϴ� �޼ҵ�
    @Override
    public List<MemberDTO> member_profile(String userId) throws Exception{
        
        return memberdao.member_profile(userId);
    }
    
 
    
}
