package com.ezen709.streetcat.service;

import java.util.Hashtable;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen709.streetcat.model.LoginDTO;

@Service
public class LoginMapper {

		@Autowired
		private SqlSession sqlSession;
		
		public LoginDTO logincheck(String id, String passwd) {
			Map<String, String> map = new Hashtable<String, String>();
			map.put("id",id);
			map.put("passwd",passwd);
			
			return sqlSession.selectOne("loginCheck",map);
		}
	
}
