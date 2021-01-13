package com.ezen709.streetcat.service;

import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen709.streetcat.model.CatBoardDTO;
import com.ezen709.streetcat.model.CatDTO;
import com.ezen709.streetcat.model.CatBoardCommentDTO;
import com.ezen709.streetcat.model.CatBoardLikeDTO;

@Service
public class CatBoardMapper {

		@Autowired
		private SqlSession sqlSession;
		
		public List<CatBoardDTO> cat_listBoard(int start, int end){
			
				Map<String, Integer> map = new Hashtable<String, Integer>();
				map.put("start", start);
				map.put("end", end);
				return sqlSession.selectList("cat_listBoard", map);
		}
		public int getCount(){
				return sqlSession.selectOne("getCount");
		}
		public void plusReadCount(int num) {
			sqlSession.update("plusReadCount", num);
	    }
		public List<CatDTO> cat_list(String location){
			Map<String, String> map = new Hashtable<String, String>();
			map.put("location", location);
			return sqlSession.selectList("cat_list",map);
		}
		public int insertBoard(CatBoardDTO dto) {
			return sqlSession.insert("cat_insertBoard",dto);
		}
		public CatDTO getCat(int cnum) {
			return sqlSession.selectOne("getCat",cnum);
		}
		public CatBoardDTO getBoard(int bnum) {
			return sqlSession.selectOne("getBoard",bnum);
		}
		public int insertComment(CatBoardCommentDTO dto) {
			String sql = null;
			if (dto.getComment_num()==0) {
				sql = "update cat_board_comment set re_step = re_step + 1";
			}else {
				sql = "update cat_board_comment set re_step = re_step + 1 where re_step > " + dto.getRe_step();
				dto.setRe_step(dto.getRe_step() + 1);
				dto.setRe_level(dto.getRe_level() + 1);
			}
			Map<String, String> map = new Hashtable<String,String>();
			map.put("sql", sql);
			sqlSession.update("plusRe_step", map);
			int res = sqlSession.insert("cat_insertComment",dto);
			int count=sqlSession.selectOne("getCommentCount",dto.getBnum());
			Map<String, Integer> countmap = new Hashtable<String, Integer>();
			countmap.put("count",count);
			countmap.put("bnum",dto.getBnum());
		    sqlSession.update("updateCommentCount",countmap);
			return res;
		}
		public List<CatBoardCommentDTO> boardComment(int bnum,int start,int end){
			Map<String, Integer> map = new Hashtable<String, Integer>();
			map.put("bnum",bnum);
			map.put("start",start);
			map.put("end",end);
			return sqlSession.selectList("cat_boardComment",map);
		}
		public CatBoardCommentDTO getComment(int num) {
			return sqlSession.selectOne("getComment",num);
		}
		public int getCommentCount(int bnum) {
			return sqlSession.selectOne("getCommentCount",bnum);
		}
		public int boardLike(CatBoardLikeDTO dto) {
			return sqlSession.insert("boardLike",dto);
		}
		public int boardUnLike(int bnum) {
			return sqlSession.delete("boardUnLike",bnum);
		}
		public int boardDelete(int bnum) {
			sqlSession.delete("boardCommentDelete",bnum);
			return sqlSession.delete("boardDelete",bnum);
		}
		public int boardEdit(CatBoardDTO dto) {
			return sqlSession.update("boardEdit",dto);
		}
		public int nextBoard(int bnum) {
			int res = 0;
			if(sqlSession.selectOne("nextBoard",bnum)!=null) {
			res = sqlSession.selectOne("nextBoard",bnum);}
			return res;
		}
		public int beforeBoard(int bnum) {
			int res = 0;
			if(sqlSession.selectOne("beforeBoard",bnum)!=null) {
				res = sqlSession.selectOne("beforeBoard",bnum);}
				return res;
		}
	}
