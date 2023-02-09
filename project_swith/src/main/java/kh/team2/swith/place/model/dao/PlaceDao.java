package kh.team2.swith.place.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.team2.swith.place.model.vo.PlaceInfo;

@Repository("placeDao")
public class PlaceDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public int insertPlace(PlaceInfo vo) throws Exception {
		return sqlSession.insert("", vo);
	}

	public int updatePlace(PlaceInfo vo) throws Exception {
		return sqlSession.update("", vo);
	}

	public int deletePlace(int p_no) throws Exception {
		return sqlSession.delete("", p_no);
	}

	public List<PlaceInfo> selectListPlace(int sigungu_code, int currentPage, int limit) throws Exception {
		int offset = (currentPage - 1)*limit; //시작 행
		RowBounds row = new RowBounds(offset, limit); // Rowbounds 객체
		
		return sqlSession.selectList("", sigungu_code, row);
	}

	public int selectPlaceCount(int sigungu_code) throws Exception {
		return sqlSession.selectOne("", sigungu_code);
	}

	public int selectPlaceCode(String sigungu, String sido) throws Exception {
		Map<String, String> result = new HashMap<String, String>();
		result.put("sigungu", sigungu);
		result.put("sido", sido);
		return sqlSession.selectOne("", result);
	}
}