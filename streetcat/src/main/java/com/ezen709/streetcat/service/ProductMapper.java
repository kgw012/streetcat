package com.ezen709.streetcat.service;

import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


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
		public int deleteProduct(int pnum, String pname) {
			if(!isPasswd(pnum	, pname)){
				return -1;
			}
			return sqlSession.delete("deleteProduct", pnum);
		}
		
		protected   boolean isPasswd(int pnum, String pname) {
			ProductDTO dto = getProduct(pnum);
			if(dto.getPname().equals(pname)) {
				return true;
			}
			return false;
		}
		
}
