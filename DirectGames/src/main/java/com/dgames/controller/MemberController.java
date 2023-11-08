package com.dgames.controller;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dgames.domain.MemberVO;
import com.dgames.dto.LoginDTO;
import com.dgames.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/member/*")
@Controller
@RequiredArgsConstructor
public class MemberController {

	private final MemberService memberService;
	private final PasswordEncoder passwordEncoder;
	
	@GetMapping("/regist")
	public void regist() {
		log.info("regist...");
	}
	
	@GetMapping("/idCheck")
	public ResponseEntity<String> idCheck(String dgm_id){
		
		log.info("아이디 : " + dgm_id);
		
		
		
		ResponseEntity<String> entity = null;
		
		//서비스 메서드 호출 구문 작업
		String idUse = "";
		if(memberService.idCheck(dgm_id) != null) {
			idUse = "no";
		}else {
			idUse = "yes";
		}
		entity = new ResponseEntity<String>(idUse, HttpStatus.OK);
		
		return entity;
	}
	
	@PostMapping("/regist")
	public String regist(MemberVO vo, RedirectAttributes rttr) {
		
		//log.info("회원정보 : " + vo);
		
		System.out.println("회원정보  : " + vo);
		
		vo.setDgm_password(passwordEncoder.encode(vo.getDgm_password()));
		
		log.info("암호화된 비밀번호 : " + vo.getDgm_password());
		//회원가입 서비스 작업 들어갈 곳
		memberService.regist(vo);
		
		return "redirect:/member/login";
	}
	
	@GetMapping("/login")
	public void login() {
		log.info("로그인 페이지 호출...");
		
	}
	
	@PostMapping("/login")
	public String login(LoginDTO dto, HttpSession session, RedirectAttributes rttr) {
		
		log.info("로그인 정보 : " + dto);
		
		MemberVO db_vo = memberService.login(dto.getDgm_id());
		
		log.info("로그인한 계정 정보 : " + db_vo);
		
		String url = "";
		String msg = "";
		
		//아이디가 일치하면
		if(db_vo != null) {
			//사용자가 입력한 비밀번호와 db에서 가져온 암호화된 비밀번호 검사
			if(passwordEncoder.matches(dto.getDgm_password(), db_vo.getDgm_password())) {
				
				//로그인 성공 시 세션형태로 저장
				session.setAttribute("loginStatus", db_vo);
				
				//로그인시간 업데이트
				//memberService.loginTimeUpdate(dto.getDgm_id());
				
				url="/";
								
			}else {
				url = "/member/login";
				msg = "비밀번호가 일치하지 않습니다.";
				rttr.addFlashAttribute("msg",msg); //로그인폼 jsp 파일에서 사용목적
			}
			
		}else {
			//아이디가 일치하지 않으면
			url="/member/login";
			msg="아이디가 일치하지 않습니다.";
			rttr.addFlashAttribute("msg",msg);			
		}
		
		
		return "redirect:"+url;
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:/";
	}
	
	@GetMapping("/mypage")
	public void mypage(HttpSession session, Model model) {
		
		String dgm_id = ((MemberVO) session.getAttribute("loginStatus")).getDgm_id();
		
		MemberVO db_vo = memberService.login(dgm_id);
		
		model.addAttribute("memberVO", db_vo);		
	}
	
	@PostMapping("/modify")
	public String modify(MemberVO vo, HttpSession session, RedirectAttributes rttr) {
		
		//로그인 시 인증목적으로 세션작업을 한 정보에서 아이디를 받아옴
		MemberVO db_vo = (MemberVO) session.getAttribute("loginStatus");
		
		String dgm_id = db_vo.getDgm_id();
		
		vo.setDgm_id(dgm_id);
		
		memberService.modify(vo);
		//header.jsp 에서 전자우편이 수정된 내용으로 반영이 안되기 때문에 필요한 작업
		db_vo.setDgm_email(vo.getDgm_email());
		session.setAttribute("loginStatus", db_vo);
		
		rttr.addFlashAttribute("msg","success");
		
		return "redirect:/";
	}
	
}
