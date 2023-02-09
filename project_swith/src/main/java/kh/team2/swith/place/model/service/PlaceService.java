package kh.team2.swith.place.model.service;

import java.util.List;

import kh.team2.swith.place.model.vo.PlaceInfo;

public interface PlaceService {
	public int insertPlace(PlaceInfo vo) throws Exception;
	public int updatePlace(PlaceInfo vo) throws Exception;
	public int deletePlace(int p_no) throws Exception;
	public List<PlaceInfo> selectListPlace(int sigungu_code, int currentPage, int limit) throws Exception;
	public int selectPlaceCount(int sigungu_code) throws Exception;
	public int selectPlaceCode(String sigungu, String sido) throws Exception;
}