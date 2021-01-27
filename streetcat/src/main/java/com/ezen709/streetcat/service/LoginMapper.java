package com.ezen709.streetcat.service;

import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen709.streetcat.model.LoginDTO;
import com.ezen709.streetcat.model.MemberDTO;

@Service
public class LoginMapper {

		@Autowired
		private SqlSession sqlSession;
		
		public LoginDTO logincheck(String userId, String passwd) {
			Map<String, String> map = new Hashtable<String, String>();
			map.put("userId",userId);
			map.put("passwd",passwd);
			
			return sqlSession.selectOne("loginCheck",map);
		}
		public int loginList(String userId) {
			return sqlSession.insert("loginList",userId);
		}
		public List<MemberDTO> loginListUp() {
			return sqlSession.selectList("loginListUp");
		}
		public int loginListOut(String userId) {
			return sqlSession.delete("loginListOut", userId);
		}
	
}
