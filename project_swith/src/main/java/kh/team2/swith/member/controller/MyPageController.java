package kh.team2.swith.member.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kh.team2.swith.member.model.service.MemberService;
import kh.team2.swith.member.model.vo.Profile;

@Controller
@RequestMapping("/mypage")
public class MyPageController {
	@Autowired
	private MemberService memberService;
	
	// 마이페이지
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String myPage0() {
		return "myPage/myPage";
	}
	@RequestMapping(value = "/myskd", method = RequestMethod.GET)
	public ModelAndView myPage1(Principal principal, ModelAndView mv) {
		String member_id = principal.getName();
		System.out.println(member_id);
		mv.addObject("profileData", memberService.selectProfile(member_id));
		mv.setViewName("myPage/mySchedule");
		return mv;
	}
	@RequestMapping(value = "/mystd", method = RequestMethod.GET)
	public ModelAndView myPage2(Principal principal, ModelAndView mv) {
		String member_id = principal.getName();
		System.out.println(member_id);
		mv.addObject("profileData", memberService.selectProfile(member_id));
		mv.setViewName("myPage/myStudy");
		return mv;
	}
	@RequestMapping(value = "/mystden", method = RequestMethod.GET)
	public ModelAndView myPage3(Principal principal, ModelAndView mv) {
		String member_id = principal.getName();
		System.out.println(member_id);
		mv.addObject("profileData", memberService.selectProfile(member_id));
		mv.setViewName("myPage/myStudyEnroll");
		return mv;
	}
	@RequestMapping(value = "/myinfo", method = RequestMethod.GET)
	public ModelAndView myPage4(Principal principal, ModelAndView mv) {
		String member_id = principal.getName();
		System.out.println(member_id);
		mv.addObject("profileData", memberService.selectProfile(member_id));
		mv.setViewName("myPage/myInfoPage");
		return mv;
	}
	@RequestMapping(value = "/myuppwd", method = RequestMethod.GET)
	public ModelAndView myPage5(Principal principal, ModelAndView mv) {
		String member_id = principal.getName();
		System.out.println(member_id);
		mv.addObject("profileData", memberService.selectProfile(member_id));
		mv.setViewName("myPage/myPwdUpdate2");
		return mv;
	}
	@RequestMapping(value = "/mymout", method = RequestMethod.GET)
	public ModelAndView myPage6(Principal principal, ModelAndView mv) {
		String member_id = principal.getName();
		System.out.println(member_id);
		mv.addObject("profileData", memberService.selectProfile(member_id));
		mv.setViewName("myPage/myLeavePage");
		return mv;
	}
}