package com.ezen709.streetcat.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ezen709.streetcat.model.MemberDTO;

@Repository
public class MemberDAOImpl implements MemberDAO {
 
    
    @Inject
    SqlSession sqlSession;
    
    
    //ȸ������ ���� �޼ҵ�
    @Override
    public void join(Map<String, Object>map, MemberDTO dto) {
 
        map.get("userId");
        map.get("passwd");
        map.get("email");
        
        sqlSession.insert("member.insertUser",map);        
    }
    
    
    //�α��ΰ��� �޼ҵ�
    @Override
    public boolean loginCheck(MemberDTO dto) {
        String name
            =sqlSession.selectOne("member.login_check", dto);
        
        //���ǽ� ? true�϶��� �� : false�϶��� ��
        return (name==null) ? false : true;
    }
 
    
    //���̵� ã�� ���� �޼ҵ�
    @Override
    public String find_idCheck(MemberDTO dto) {
        String id = sqlSession.selectOne("member.find_id_check", dto);
        return id;
        
    }
 
    
    //��й�ȣ ã�� ���� �޼ҵ�
    @Override
    public String find_passCheck(MemberDTO dto) {
        String pass = sqlSession.selectOne("member.find_pass_check", dto);
        return pass;
    }
 
    
    //ȸ�� ���� ���� �޼ҵ�
    //��ư�� Ŭ���� ȸ���� ������ ȸ�� ���̺� �����ؼ� ����� �� �ְ� ��
    @Override
    public void authentication(MemberDTO dto) {
        
        sqlSession.insert("member.authentication", dto);
        
    }
 
 
    @Override
    public void pass_change(Map<String, Object> map, MemberDTO dto)throws Exception{
        
        map.get("passwd");
        map.get("email");
 
        sqlSession.update("member.pass_change", map);
    }
 
 
    @Override
    public boolean email_check(String email) throws Exception {
        String emailString
        =sqlSession.selectOne("member.email_check", email);
    
        //���ǽ� ? true�϶��� �� : false�϶��� ��
        return (emailString==null) ? true : false;
        
    }
 
 
    @Override
    public boolean join_id_check(String userId) throws Exception {
        String user_id1
        =sqlSession.selectOne("member.join_id_check", userId);
    
        //���ǽ� ? true�϶��� �� : false�϶��� ��
        return (user_id1==null) ? true : false;
    }
 
    
    //ȸ���� ������ ������ �����Ѵ�.
    @Override
    public List<MemberDTO> member_profile(String userId) throws Exception {
        
        return sqlSession.selectList("member.member_profile", userId);
    }
    
}
