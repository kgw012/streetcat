package com.ezen709.streetcat.dao;

import java.util.List;
import java.util.Map;

import com.ezen709.streetcat.model.MemberDTO;

public interface MemberDAO {
	 
    public void join(Map<String, Object>map,MemberDTO dto);     //ȸ������ ����
    
    public boolean loginCheck(MemberDTO dto);        //�α��� ����
    
    public String find_idCheck(MemberDTO dto);        //���̵� ã��
    
    public String find_passCheck(MemberDTO dto);    //��й�ȣ ã��
 
    public void authentication(MemberDTO dto);        //�Ҽ� �α��� ȸ������ ���� �޼ҵ�
 
    public void pass_change(Map<String, Object> map, MemberDTO dto)throws Exception;    //��й�ȣ ����
 
    public boolean email_check(String e_mail) throws Exception;    //�̸��� �ߺ� Ȯ��
 
    public boolean join_id_check(String user_id)throws Exception;    //���̵� �ߺ� Ȯ��
 
    public List<MemberDTO> member_profile(String user_id) throws Exception;    //ȸ���� ������ ������ Ȯ���� �� �ִ� �޼ҵ�
    
}
