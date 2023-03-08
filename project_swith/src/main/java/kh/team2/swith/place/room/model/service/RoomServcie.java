package kh.team2.swith.place.room.model.service;

import java.util.List;

import kh.team2.swith.place.room.model.vo.StudyRoom;

public interface RoomServcie {
	public int insertRoom(StudyRoom vo) throws Exception;
	public int insertRoomList(List<StudyRoom> voList) throws Exception;
	public int updateRoom(StudyRoom vo) throws Exception;
	public int updateRoomImg(StudyRoom vo) throws Exception;
	public int deleteRoom(int room_no) throws Exception;
	public int deleteRoomImg(int room_img_no) throws Exception;
	public StudyRoom selectRoom(int room_no) throws Exception;
	public List<StudyRoom> selectListRoom(int p_no) throws Exception;
	public int selectRoomCount() throws Exception;
	public int selectRoomNo(int p_no, String room_name) throws Exception;
}
