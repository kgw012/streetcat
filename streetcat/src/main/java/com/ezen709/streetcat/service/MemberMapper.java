package com.ezen709.streetcat.service;

import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ezen709.streetcat.model.CatBoardCommentDTO;
import com.ezen709.streetcat.model.CatBoardDTO;
import com.ezen709.streetcat.model.MemberDTO;
import com.ezen709.streetcat.model.MessageDTO;




@Service
public class MemberMapper {

	
	@Autowired
	private SqlSession sqlSession;
	
	public int insertMember(MemberDTO dto) {
		
		int res = sqlSession.insert("insertMember",dto);
		return res;
		
	}
	
	public List<MemberDTO> listMember(){
		return sqlSession.selectList("listMember");
	}
	
	public  List<MemberDTO> findMember(String search, String searchString) {
		String sql = null;
		if(	search.toString().equals("userId") ) {
			sql = "select * from cat_user where userId = '"+searchString+"'" ;
		}else {
			sql = "select * from cat_user where name = '"+searchString+"'" ;
		}
		
		Map<String, String> map = new Hashtable<>();
		map.put("sql",sql);
		
		return sqlSession.selectList("findMember", map);
	}
	
	public MemberDTO getMember(int num) {
	     
	      MemberDTO dto = sqlSession.selectOne("getMember", num);
	      return dto;
	   }
	
	
	public int  upgradeMember(MemberDTO dto) {
		
		
		int res = sqlSession.update("upgradeMember",dto);
		
		return res;
	}
	public int deleteMember(int unum, String check) {
		if(!check.toString().equals("check")){
			return -1;
		}
		return sqlSession.delete("deleteMember", unum);
	}
	
	//아이디 체크
	public int idCheck(String userId) {
		System.out.println("===> Mybatis로 idCheck");
		int result = sqlSession.selectOne("idCheck",userId);
		return result;
	}
	
	//회원가입
	public void signUp(MemberDTO dto) {
		System.out.println("===> Mybatis로 회원가입(signUp)");
		sqlSession.insert("signUp",dto);
	}
	public int sendMessage(MessageDTO dto) {
		return sqlSession.insert("messageSend",dto);
	}
	public List<MessageDTO> getMessage(String receiveId){
		return sqlSession.selectList("getMessage",receiveId);
	}
	public List<MessageDTO> getSendMessage(String sendId){
		return sqlSession.selectList("getSendMessage",sendId);
	}
	public MessageDTO getMessageContent(int mnum){
		return sqlSession.selectOne("getMessageContent",mnum);
	}
	public int receiveDelete(int mnum) {
		return sqlSession.update("receiveDelete",mnum);
	}
	public int sendDelete(int mnum) {
		return sqlSession.update("sendDelete",mnum);
	}
	public int messageRead(int mnum) {
		return sqlSession.update("messageRead",mnum);
	}
	public int getMessageCount(String mnum) {
		return sqlSession.selectOne("getMessageCount",mnum);
	}
	//myPage methods
	public List<CatBoardDTO> getMemberBoardList(String writer){
		return sqlSession.selectList("getMemberBoardList", writer);
	}
	public List<CatBoardCommentDTO> getMemberCommentList(String writer){
		return sqlSession.selectList("getMemberCommentList", writer);
	}
}
