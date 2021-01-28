package com.ezen709.streetcat.dao;

import java.util.List;
import java.util.Map;

import com.ezen709.streetcat.model.MemberDTO;

public interface MemberDAO {
	 
    public void join(Map<String, Object>map,MemberDTO dto);     //회원가입 관련
    
    public boolean loginCheck(MemberDTO dto);        //로그인 관련
    
    public String find_idCheck(MemberDTO dto);        //아이디 찾기
    
    public String find_passCheck(MemberDTO dto);    //비밀번호 찾기
 
    public void authentication(MemberDTO dto);        //소셜 로그인 회원인증 관련 메소드
 
    public void pass_change(Map<String, Object> map, MemberDTO dto)throws Exception;    //비밀번호 변경
 
    public boolean email_check(String e_mail) throws Exception;    //이메일 중복 확인
 
    public boolean join_id_check(String user_id)throws Exception;    //아이디 중복 확인
 
    public List<MemberDTO> member_profile(String user_id) throws Exception;    //회원의 프로필 정보를 확인할 수 있는 메소드
    
}
