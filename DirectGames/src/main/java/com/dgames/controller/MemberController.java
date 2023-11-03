package com.dgames.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dgames.domain.MemberVO;
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
		
		log.info("회원정보 : " + vo);
		
		vo.setDgm_password(passwordEncoder.encode(vo.getDgm_password()));
		
		log.info("암호화된 비밀번호 : " + vo.getDgm_password());
		//회원가입 서비스 작업 들어갈 곳
		memberService.regist(vo);
		
		return "redirect:/member/login";
	}
}
