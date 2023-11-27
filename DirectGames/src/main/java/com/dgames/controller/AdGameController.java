package com.dgames.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.dgames.domain.GameVO;
import com.dgames.service.AdCategoryService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;


@Controller
@Log4j
@RequestMapping("/admin/game/*")
@RequiredArgsConstructor
public class AdGameController {
	
	private final AdCategoryService adCategoryService;
	
	//메인 및 썸네일 이미지 업로드 폴더경로 주입작업
	@Resource(name="uploadPath") //servlet-context.xml bean id참조
	private String uploadPath;
	
	//CKEditor에서 사용되는 업로드 폴더 경로
	@Resource(name="uploadCKPath") //servlet-context.xml bean id참조
	private String uploadCKPath;
	
	//상품등록 폼
	@GetMapping("/game_insert")
	public void game_insert() {		
	}
	
	//파일이 여러개일 경우 List<MultipartFile> 감싸줘야 함
	//파일 업로드 기능 : 1)스프링에서 지원하는 기본 라이브러리 servlet-context.xml 에서 MultipartFile에 대한 bean 등록 필요
	//			   2)외부 라이브러리(pom.xml). servlet-context.xml 에서 MultipartFile에 대한 bean 등록 필요
	@PostMapping("/game_insert")
	public String game_insert(GameVO vo, MultipartFile uploadFile) {
		
		return "";
	}
	
	//CkEditor 업로드 탭에서 파일업로드시 동작하는 매핑주소
	//MultipartFile upload 변수와 CkEditor의 <input type="file" name="upload" size="38">일치
	//MultipartFile upload : 업로드 된 파일을 참조하는 객체
	//HttpServletRequest 클래스 : jsp의 request객체 클래스. 클라이언트의 요청을 담고있는 객체
	//HttpServletResponse 클래스 : jsp의 response객체 클래스. 클라이언트로 보낼 서버측의 응답정보를 가지고있는 객체.

	@PostMapping("imageUpload")
	public void imageUpload(HttpServletRequest request, HttpServletResponse response, MultipartFile upload) {
				
	}
	
}
