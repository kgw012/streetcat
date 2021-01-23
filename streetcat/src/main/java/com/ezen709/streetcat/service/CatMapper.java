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
	
	public List<CatDTO> getCatList(){
		return sqlSession.selectList("getCatList");
	}
	
	public List<CatDTO> findCatList(String searchString, String search){
		String sql = null;
		if(search == null || search.equals("")) {
			sql = "select * from cat";
		}else {
			sql = "select * from cat where " + searchString + " = '" + search + "'";
		}

		Map<String, String> map = new Hashtable<>();
		map.put("sql", sql);
		
		List<CatDTO> list = sqlSession.selectList("findCat", map);
		return list;
	}
	
	public List<CatDTO> findCatListByLocation(double lat, double lon){
		double lat_min = lat - 1 / 109.958489129649955;
		double lat_max = lat + 1 / 109.958489129649955;
		double lon_min = lon - 1 / 88.74;
		double lon_max = lon + 1 / 88.74;
		String sql = "SELECT * FROM cat WHERE "
				+ " ( location_lat BETWEEN " + lat_min + " AND " + lat_max + " ) "
				+ " AND "
				+ " ( location_long BETWEEN " + lon_min + " AND " + lon_max + " ) ";
		
		Map<String, String> map = new Hashtable<>();
		map.put("sql", sql);
		
		List<CatDTO> list = sqlSession.selectList("findCat", map);
		return list;
	}
	
	public int insertCat(CatDTO dto) {
		return sqlSession.insert("insert_cat", dto);
	}
	
	public CatDTO getCatByCnum(int cnum) {
		return sqlSession.selectOne("getCatByCnum", cnum);
	}
	
	public int editCat(CatDTO dto) {
		return sqlSession.update("edit_cat", dto);
	}
	
	public int deleteCat(int cnum) {
		return sqlSession.delete("delete_cat", cnum);
	}
}