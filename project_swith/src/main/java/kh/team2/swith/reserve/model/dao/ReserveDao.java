package kh.team2.swith.reserve.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.team2.swith.reserve.model.vo.CancelReserveInfo;
import kh.team2.swith.reserve.model.vo.ReserveInfo;

@Repository
public class ReserveDao {
	@Autowired
	private SqlSession session;
	
	public int insertReserve(ReserveInfo vo) {
		return session.insert("reserve.insertReserve", vo);
	}
	public int updateReserve(ReserveInfo vo) {
		return session.update("reserve.updateReserve", vo);
	}
	public int deleteReserve(int reserve_no) {
		return session.delete("reserve.deleteReserve", reserve_no);
	}
	//TODO hhjng
	public ReserveInfo selectReserve(int reserve_no) {
		return session.selectOne("reserve.selectReserve", reserve_no);
	}
	public List<ReserveInfo> selectListReserve(){
		return session.selectList("reserve.selectListReserve");
	}
	//TODO hhjng
	public int selectReserveCount() {
		return 0;
	}
	public CancelReserveInfo selectCancelReserve(int reserve_no) {
		return session.selectOne("", reserve_no);
	}
}
