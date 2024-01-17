package com.dgames.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dgames.domain.GameVO;
import com.dgames.dto.Criteria;
import com.dgames.dto.PageDTO;
import com.dgames.service.AdGameService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;


@Controller
@Log4j
@RequestMapping("/admin/game/*")
@RequiredArgsConstructor
public class AdGameController {
	
	private final AdGameService adGameService;
	
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
		
		//파일업로드 작업. 선수작업: FileUtils 클래스 작업
		String dateFolder = FileUtils.getDateFolder();
		String savedFileName = FileUtils.uploadFile(uploadPath, dateFolder, uploadFile);
		
		vo.setGame_img(savedFileName);
		vo.setImg_up_folder(dateFolder);
		
		System.out.println("상품정보 : " + vo);
		
		//상품정보를 DB에 저장
		adGameService.game_insert(vo);
		
		return "redirect:/admin/game/game_list"; //상품리스트 주소 이동
	}
	
	//CkEditor 업로드 탭에서 파일업로드시 동작하는 매핑주소
	//MultipartFile upload 변수와 CkEditor의 <input type="file" name="upload" size="38">일치
	//MultipartFile upload : 업로드 된 파일을 참조하는 객체
	//HttpServletRequest 클래스 : jsp의 request객체 클래스. 클라이언트의 요청을 담고있는 객체
	//HttpServletResponse 클래스 : jsp의 response객체 클래스. 클라이언트로 보낼 서버측의 응답정보를 가지고있는 객체.

	@PostMapping("imageUpload")
	public void imageUpload(HttpServletRequest request, HttpServletResponse response, MultipartFile upload) {
		
		// try 코드 사용전에 선언한 목적
		OutputStream out = null;
		PrintWriter printWriter = null; // 클라이언트에게 서버의 응답정보를 보낼때 사용.
		
		//jsp파일
		/*
		 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
		 */
		
		// 클라이언트에게 보내는 응답설정
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		try {
			
			//1) 파일업로드 작업
			String fileName = upload.getOriginalFilename(); // 클라이언트에서 전송한 파일이름
			byte[] bytes = upload.getBytes(); // 업로드 한 파일을 byte배열로 읽어들임.
			
			String ckUploadPath = uploadCKPath + fileName;
			
			System.out.println("CKEditor파일경로: " + ckUploadPath);
			
			out = new FileOutputStream(new File(ckUploadPath)); // 0kb 파일생성.
			
			out.write(bytes); // 출력스트림작업
			out.flush();
			
			//2) 파일업로드 작업후 파일정보를 CKEditor로 보내는 작업
			printWriter = response.getWriter();
			
			// 브라우저의 CKEditor에서 사용할 업로드한 파일정보를 참조하는 경로설정. 
			// 1)톰캣 Context Path에서 Add External Web Module 작업을 해야 함.
			// Path : /ckupload, Document Base : C:\\dev\\upload\\ckeditor 설정
			// 2)Tomcat server.xml에서 <Context docBase="업로드경로" path="/매핑주소" reloadable="true"/>
			//  <Context docBase="C:\\dev\\upload\\ckeditor" path="/ckupload" reloadable="true"/>
			
			// CKeditor에서 업로드된 파일경로를 보내준다.(매핑주소와 파일명이 포함)
			String fileUrl = "/ckupload/" + fileName; 
			// {"filename":"abc.gif", "uploaded":1, "url":"/upload/abc.gif"}
			printWriter.println("{\"filename\":\"" +  fileName + "\", \"uploaded\":1,\"url\":\"" + fileUrl + "\"}");
			printWriter.flush();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(out != null) {
				try {
					out.close();
				}catch(Exception ex) {
					ex.printStackTrace();
				}
			}
			if(printWriter != null) printWriter.close();
		}
				
	}

	
	//상품리스트.  (목록과페이징) .. 메서드의 파라미터를 스프링에서 자동으로 객체생성
	@GetMapping("/game_list")
	public void game_list(Criteria cri, Model model) throws Exception {
		
		// this(1, 10);
		// 10 -> 2
		cri.setAmount(5);
		
		
		List<GameVO> game_list = adGameService.game_list(cri);
		
		// 날짜폴더의 역슬래시를 슬래시로 바꾸는 작업.  이유? 역슬래시로 되어있는 정보가 스프링으로 보내는 요청데이타에 사용되면 에러발생.
		// 스프링에서 처리 안하면, 자바스크립에서 처리 할수도 있다.
		game_list.forEach(vo -> {
			vo.setImg_up_folder(vo.getImg_up_folder().replace("\\", "/"));
		});
		model.addAttribute("game_list", game_list);
		
		int totalCount = adGameService.getTotalCount(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, totalCount));
	}
	
	//상품리스트에서 보여줄 이미지.  <img src="매핑주소">
	@ResponseBody
	@GetMapping("/imageDisplay") // /admin/product/imageDisplay?dateFolderName=값1&fileName=값2
	public ResponseEntity<byte[]> imageDisplay(String dateFolderName, String fileName) throws Exception {
		
		return FileUtils.getFile(uploadPath + dateFolderName, fileName);
	}
	
	
	//체크상품 목록 수정(ajax요청) 방법1
	// 일반요청:  배열형태로 파라미터가 전송되어오면.@RequestParam("game_id_arr")  []를 제외
	@ResponseBody
	@PostMapping("/game_checked_modify1")
	public ResponseEntity<String> game_checked_modify1(
			@RequestParam("game_id_arr[]") List<Integer> game_id_arr,
			@RequestParam("game_price_arr[]") List<Integer> game_price_arr,
			@RequestParam("game_status_arr[]") List<String> game_status_arr
			) throws Exception {
		
		System.out.println("게임코드:" + game_id_arr);
		System.out.println("가격:" + game_price_arr);
		System.out.println("판매여부:" + game_status_arr);
		
		ResponseEntity<String> entity = null;


		//체크상품수정작업
		adGameService.game_checked_modify1(game_id_arr, game_price_arr, game_status_arr);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	// 방법2
	@ResponseBody
	@PostMapping("/game_checked_modify2")
	public ResponseEntity<String> game_checked_modify2(
			@RequestParam("game_id_arr[]") List<Integer> game_id_arr,
			@RequestParam("game_price_arr[]") List<Integer> game_price_arr,
			@RequestParam("game_status_arr[]") List<String> game_status_arr
			) throws Exception {
		
		System.out.println("상품코드:" + game_id_arr);
		System.out.println("가격:" + game_price_arr);
		System.out.println("판매여부:" + game_status_arr);
		
		
		
		ResponseEntity<String> entity = null;


		//체크상품수정작업
		adGameService.game_checked_modify2(game_id_arr, game_price_arr, game_status_arr);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	
	// 상품수정 폼 페이지
	@GetMapping("/game_edit")
	public void game_edit(@ModelAttribute("cri") Criteria cri, Integer game_id, Model model) throws Exception {
		
		// 선택한 상품정보
		GameVO vo = adGameService.game_edit(game_id);
		System.out.println("상품 상세 정보 : "+ vo);
		// 역슬래시를 슬래시로 변환하는 작업.  ( \ -> / )
		// 요청 타겟에서 유효하지 않은 문자가 발견되었습니다. 유효한 문자들은 RFC 7230과 RFC 3986에 정의되어 있습니다.
		vo.setImg_up_folder(vo.getImg_up_folder().replace("\\", "/")); // Escape Sequence 특수문자.
		model.addAttribute("gameVO", vo);				
		
	}

	
	//상품수정
	@PostMapping("/game_edit")
	public String pro_edit(Criteria cri, GameVO vo, MultipartFile uploadFile, RedirectAttributes rttr) throws Exception {
		
		// 상품리스트에서 사용할 정보(검색,페이징정보)
		System.out.println("검색페이징정보" + cri);
		//상품수정내용
		System.out.println("상품수정내용" + vo);
		
		vo.setImg_up_folder(vo.getImg_up_folder().replace("/", "\\"));
		
		//작업
		// 파일이 변경될 경우 해야 할 작업  1)기존이미지 파일삭제  2) 업로드작업
		// 참고>클라이언트 파일명을 db에 저장하는 부분..
		// 첨부파일 확인할 때 조건식으로 사용:  uploadFile.getSize() > 0
		if(!uploadFile.isEmpty()) {
			
			//1)기존이미지파일삭제작업.
			FileUtils.deleteFile(uploadPath, vo.getImg_up_folder(), vo.getGame_img());
			
			//2)업로드작업
			String dateFolder = FileUtils.getDateFolder();
			String savedFileName = FileUtils.uploadFile(uploadPath, dateFolder, uploadFile);
			
			//3)db에 저장할 새로운 날짜폴더명및이미지명 변경작업.
			vo.setGame_img(savedFileName);
			vo.setImg_up_folder(dateFolder);
			
		}
		
		//db연동작업
		adGameService.game_edit(vo);
		
		
		return "redirect:/admin/game/game_list" + cri.getListLink();
	}
	
	
	// 게임상품 삭제
	@PostMapping("/game_delete")
	public String game_delete(Criteria cri, Integer game_id) throws Exception {
		
		
		// db연동 작업
		adGameService.game_delete(game_id);
		
		return "redirect:/admin/game/game_list" + cri.getListLink();
	}
	
}
