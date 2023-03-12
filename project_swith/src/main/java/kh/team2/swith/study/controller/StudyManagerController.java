package kh.team2.swith.study.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kh.team2.swith.member.model.service.MemberService;
import kh.team2.swith.member.model.vo.Inform;
import kh.team2.swith.study.model.service.StudyParticipantService;
import kh.team2.swith.study.model.service.StudyReserverService;
import kh.team2.swith.study.model.service.StudyService;
import kh.team2.swith.study.model.vo.StudyParticipant;
import kh.team2.swith.study.model.vo.StudyReserver;

@Controller
@RequestMapping("/studyManager")
public class StudyManagerController {


	@Autowired
	private StudyParticipantService spService;
	@Autowired
	private StudyReserverService srService;
	@Autowired
	private StudyService studyService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private DataSource dataSource;
	
	@PostMapping("/participantList.lo")
	@ResponseBody
	public String selectListStudyParticipant(@RequestParam("study_no") int study_no) throws Exception {
		List<StudyParticipant> voList = spService.selectStudyList(study_no);
		int cnt = spService.selectStudyListCnt(study_no);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("voList", voList);
		resultMap.put("cnt", cnt);
		return new Gson().toJson(resultMap);
	}
	
	@PostMapping("/reserverList.lo")
	@ResponseBody
	public String selectListStudyReserver(@RequestParam("study_no") int study_no) throws Exception {
		List<StudyReserver> voList = srService.selectStudyList(study_no);
		return new Gson().toJson(voList);
	}
	
	@PostMapping("/transfer.lo")
	@ResponseBody
	public String updateStudyManagerTransfer(
			@RequestParam("agr_number") int agr_number
			,@RequestParam("study_no") int study_no
			,Principal principal
			) {
		int result = 0;

		//트랙잭션을 수동으로 처리하기 위한 설정
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		DataSourceTransactionManager txManager = new DataSourceTransactionManager(dataSource);
		TransactionStatus sts = txManager.getTransaction(def);
		
		// 현재 로그인 정보 가져오기
		String loginMemberId = principal.getName();
		try {
			// 현재 로그인한 회원의 해당 스터디 참가자 정보 가져오기
			StudyParticipant loginParticipantVo = spService.selectOneStudyParticipantMember(loginMemberId, study_no);
			// 양도 받을 참가자 번호로 아이디,스터디명 가져오기
			Map<String, String> resultMap = spService.selectStudyParticipantAgrNo(agr_number);
			
			// 권한 수정
			//양도 받는 참가자로 스터디장 변경
			if(spService.updateStudyParticipantTransfer(1, agr_number) > 0) {
				 //현재 스터디장 일반스터디원으로 변경
				if(spService.updateStudyParticipantTransfer(2, loginParticipantVo.getAgr_number()) > 0) {
					// 알람 정보 넣기
					Inform informVo = new Inform();
					String infromContent = resultMap.get("STUDY_NAME")+" 모임의 스터디장이 회원님으로 변경되었습니다.";
					informVo.setInform_content(infromContent);
					informVo.setMember_id(resultMap.get("MEMBER_ID"));
					
					//양도 받을 참가자에게 알람 정보 넣기
					result = memberService.insertInform(informVo);
					if(result > 0) {
						txManager.commit(sts);
					} else {
						txManager.rollback(sts);
					}
					
				} else {
					txManager.rollback(sts);
				}
			} else {
				txManager.rollback(sts);
			}
		} catch(Exception e) {
			txManager.rollback(sts);
		}
		
		
		return new Gson().toJson(result);
	}
}