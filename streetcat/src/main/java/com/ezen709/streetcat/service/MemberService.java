package com.ezen709.streetcat.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.ezen709.streetcat.model.MemberDTO;

public interface MemberService {
        
    
    public void join (Map<String, Object>map,MemberDTO dto); //ȸ������ ����
    
    
    public boolean loginCheck(MemberDTO dto, HttpSession session);    //�α��� ����
    
    
    public String find_idCheck(MemberDTO dto);    //���̵� ã�� ����
    
    
    public String find_passCheck(MemberDTO dto);    //��й�ȣ ã�� ����
    
    
    public void authentication(MemberDTO dto);        //ȸ�� �������� �޼ҵ�
    
    
    public void pass_change(Map<String, Object> map, MemberDTO dto)throws Exception;    //��й�ȣ ����
    
    
    public boolean email_check(String e_mail) throws Exception;    //�̸��� �ߺ�Ȯ���� �ϴ� �޼ҵ�
    
    
    public boolean join_id_check(String user_id) throws Exception;    //ȸ�����Խ� ���̵� üũ�ϴ� �޼ҵ�
    
    
    public List<MemberDTO> member_profile(String user_id) throws Exception;    //ȸ���� �������� �� �� �ִ� �޼ҵ�
    
    
 
}