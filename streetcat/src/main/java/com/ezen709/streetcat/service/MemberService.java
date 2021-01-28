package com.ezen709.streetcat.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.ezen709.streetcat.model.MemberDTO;

public interface MemberService {
        
    
    public void join (Map<String, Object>map,MemberDTO dto); //회원가입 관련
    
    
    public boolean loginCheck(MemberDTO dto, HttpSession session);    //로그인 관련
    
    
    public String find_idCheck(MemberDTO dto);    //아이디 찾기 관련
    
    
    public String find_passCheck(MemberDTO dto);    //비밀번호 찾기 관련
    
    
    public void authentication(MemberDTO dto);        //회원 인증관련 메소드
    
    
    public void pass_change(Map<String, Object> map, MemberDTO dto)throws Exception;    //비밀번호 변경
    
    
    public boolean email_check(String e_mail) throws Exception;    //이메일 중복확인을 하는 메소드
    
    
    public boolean join_id_check(String user_id) throws Exception;    //회원가입시 아이디를 체크하는 메소드
    
    
    public List<MemberDTO> member_profile(String user_id) throws Exception;    //회원의 프로필을 볼 수 있는 메소드
    
    
 
}