package com.ezen709.streetcat.service;

import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen709.streetcat.model.MemberDTO;
import com.ezen709.streetcat.model.ProdLikeDTO;
import com.ezen709.streetcat.model.ProductDTO;

@Service
public class ProductMapper {
	
		@Autowired
		private SqlSession sqlSession;
		
		public List<ProductDTO> listProduct(int start, int end){
				Map<String,Integer> map = new Hashtable<>();
				map.put("start",start);
				map.put("end", end);
				return sqlSession.selectList("listProduct",map);
						
		}
		public  int getCountProd() {
			return sqlSession.selectOne("getCountProd");
			
	}
		
		public  int insertProduct(ProductDTO dto) {
			
			int res = sqlSession.insert("insertProduct",dto);
			
			return res;			
	}
		public ProductDTO getProduct(int pnum) {
		   
		      ProductDTO dto = sqlSession.selectOne("getProduct", pnum);
		      return dto;
		   }
		public int  updateProduct(ProductDTO dto) {
		
			
			int res = sqlSession.update("updateProduct",dto);
			
			return res;
		}
		public int deleteProduct(int pnum, String delete) {
			if(delete =="delete"){
				return -1;
			}
			return sqlSession.delete("deleteProduct", pnum);
		}
		
		public int getProdLike(int pnum, int unum ) {
			Map<String,Integer> map = new Hashtable<>();
			map.put("pnum", pnum);
			map.put("unum", unum);
			int res = sqlSession.selectOne("getProdLike",map);
		  
			return res;
		}
		public int getProdLikeAll(int pnum) {
		
			int res = sqlSession.selectOne("getProdLikeAll",pnum);
		  
			return res;
		}
		
		public int plusProdLike(int pnum, int mbNo) {
			Map<String,Integer> map = new Hashtable<>();
			map.put("pnum", pnum);
			map.put("mbNo", mbNo);
			
			int res = sqlSession.insert("plusProdLike", map);
			return res;
		}
		public int minusProdLike(int pnum, int mbNo) {
			Map<String,Integer> map = new Hashtable<>();
			map.put("pnum", pnum);
			map.put("mbNo", mbNo);
			
			int res = sqlSession.delete("minusProdLike", map);
			return res;
		}
		public void updateLike(int pnum, int plike) {
			Map<String,Integer> map = new Hashtable<>();
			map.put("pnum", pnum);
			map.put("plike", plike);
			sqlSession.update("updateLike", map);
			
		}
	
}
