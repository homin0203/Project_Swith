package kh.team2.swith.area.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.team2.swith.area.model.vo.Area;

@Repository
public class AreaDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public Area selectOne(String area_code) throws Exception {
		return sqlSession.selectOne("area.selectOne", area_code);
	}

	public List<Area> selectList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("area.selectList");
	}
}