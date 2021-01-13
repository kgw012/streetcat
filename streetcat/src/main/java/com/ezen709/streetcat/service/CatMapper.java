package com.ezen709.streetcat.service;

import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen709.streetcat.model.CatDTO;

@Service
public class CatMapper {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<CatDTO> findCatList(String searchString, String search){
		String sql = "select * from cat where " + searchString + " = " + search;

		Map<String, String> map = new Hashtable<>();
		map.put("sql", sql);
		
		List<CatDTO> list = sqlSession.selectList("findCat", map);
		return list;
	}
}