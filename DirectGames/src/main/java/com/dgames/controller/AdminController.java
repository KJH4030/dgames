package com.dgames.controller;

import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dgames.domain.AdminVO;
import com.dgames.service.AdminService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller //클라이언트의 요청을 담당하는 기능. bean으로 생성 및 등록 : adminController
@Log4j
@RequiredArgsConstructor
@RequestMapping("/admin/**")
public class AdminController {
	
	private final AdminService adminService;
	
	private final PasswordEncoder passwordEncoder;
	
	//관리자 로그인 페이지
	@GetMapping("/intro")
	public String adminLogin() {
		
		System.out.println("admin Login..");
		
		return "/admin/ad_login";
	}
	
	//관리자 로그인 인증
	@PostMapping("/admin_ok")
	public String admin_ok(AdminVO vo, HttpSession session, RedirectAttributes rttr) throws Exception {
		
		System.out.println("관리자 로그인 : " + vo);
		
		AdminVO db_vo = adminService.admin_ok(vo.getAdmin_id());
		
		System.out.println("db_vo : " + db_vo);
		
		String url = "";
		String msg = "";
		
		// 아이디가 일치하는 경우
		if(db_vo != null) {
			//사용자가 입력한 비밀번호 (평뮨텍스트)와 db에서 가져온 비밀번호 암호화된 비밀번호 검사
			if(passwordEncoder.matches(vo.getAdmin_pw(), db_vo.getAdmin_pw())) {
				//로그인 성공결과를 세션형태로 저장
				session.setAttribute("adminStatus", db_vo);
				
				//로그인 시간 업데이트
				adminService.login_date(vo.getAdmin_id());
				
				url = "/admin/ad_menu"; // 관리자 메뉴페이지 주소
			}else {
				url = "/admin/intro";
				msg = "failPW";
				rttr.addFlashAttribute("msg",msg); // 로그인폼 jsp 파일에서 사용 목적
			}
		}else {
			//아이디가 일치하지 않는 경우
			url = "/admin/intro";
			msg = "failID";
			rttr.addFlashAttribute("msg",msg); // 로그인폼 jsp 파일에서 사용 목적
		}
		
		return "redirect:"+url;
		
	}
	
	
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:/admin/intro";
	}
	
	//관리자 메뉴 페이지
	@GetMapping("/ad_menu")
	public void ad_menu() {
		
	}
	
	
	
}
