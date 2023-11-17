package com.dgames.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dgames.domain.NoticeVO;
import com.dgames.dto.Criteria;
import com.dgames.dto.PageDTO;
import com.dgames.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;


@RequestMapping("/board/*")
@Log4j
@RequiredArgsConstructor
@Controller
public class BoardController {
	
	private final BoardService boardService;	


	
	//CKEditor에서 사용되는 업로드 폴더 경로
	@Resource(name="uploadCKPath") //servlet-context.xml bean id참조
	private String uploadCKPath;
	
	
	//공지사항 등록 페이지
	@GetMapping("/notice/ntc_regist")
	public void ntc_regist() {
		
	}
	
	//공지사항 등록 기능
	@PostMapping("/notice/ntc_regist")
	public String ntc_Regist(NoticeVO noticeVO) {
		
		boardService.ntc_regist(noticeVO);
		
		return "redirect:/board/notice/ntc_list";
	}
	
	//공지사항 이미지 등록
	@PostMapping("/notice/ntc_imageUpload")
	public void imageUpload(HttpServletRequest request, HttpServletResponse response, MultipartFile upload) {
		
		//try 코드 사용 전에 선언한 목적 
		OutputStream out = null;
		PrintWriter printWriter = null; //클라이언트에 서버의 응답정보를 보낼 때 사용
		
		//jsp파일
		/*
		 * <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		 * 
		 */
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		try {
			String fileName = upload.getOriginalFilename(); // 클라이언트에서 전송한 파일이름
			
			byte[] bytes = upload.getBytes(); //업로드 한 파일을 byte배열로 읽어들임
			
			String ckUploadPath = uploadCKPath + fileName;
			
			log.info("CKEditor 파일 경로 : " + ckUploadPath);
			
			out = new FileOutputStream(new File(ckUploadPath)); //0kb파일 생성
			
			out.write(bytes); //출력스트림 작업
			out.flush();
			
			//2) 파일업로드 작업 후 파일정보를 CKEditor로 보내는 작업
			printWriter = response.getWriter();
			
			// 브라우저의 CKEditor에서 사용할 업로드한 파일 정보를 참조하는 경로설정
			// 1)톰캣 Context Path에서 Add External Web Module 작업을 해야 함.
			// Path : /upload, Document Base : C:\\dev\\dg_files\\ckeditor 설정
			// 2)Tomcat server.xml에서 <Context docBase="업로드경로" path="매핑주소" reloadable="true"/>
			// <Context docBase="C:\\dev\\dg_files\\ckeditor" path="/ckupload" reloadable="true"/>
			 
			//CKeditor에서 업로드 된 파일경로를 보내준다.(매핑주소와 파일명이 포함)
			String fileUrl = "/ckupload/" + fileName;
			// {"filename":"abc.gif", "uploaded":1, "url":"/upload/abc.gif"}
			printWriter.println("{\"filename\":\"" +  fileName + "\", \"uploaded\":1,\"url\":\"" + fileUrl + "\"}");
			printWriter.flush();
			
		} catch (Exception e) {
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
	
	
	//공지사항 게시판 목록
	@GetMapping("/notice/ntc_list")
	public void ntc_list(Criteria cri, Model model) {
		
		log.info("list : " + cri);
		
		//1)목록 데이터
		List<NoticeVO> ntc_list = boardService.ntc_list(cri);
		model.addAttribute("ntc_list",ntc_list);
		
		//2)페이징 기능 - PageDTO
		int total = boardService.ntc_count(cri);
		
		log.info("데이타 총개수: " + total);
		
		PageDTO pageDTO = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageDTO);
		
		log.info("페이징정보: " + pageDTO);
	}
	
	//공지사항 게시글 읽기
	@GetMapping({"/notice/ntc_get", "/notice/ntc_modify"})
	public void ntc_get(@RequestParam("ntc_id") Long ntc_id, @ModelAttribute("cri") Criteria cri,  Model model) {
		
		log.info("게시물 번호 :" + ntc_id);
		log.info("페이지, 검색 정보 :" + cri);
		
		NoticeVO notice = boardService.ntc_get(ntc_id);
		model.addAttribute("notice",notice);
	}
	
	//공지사항 게시글 수정
	@PostMapping("notice/ntc_modify")
	public String ntc_modify(NoticeVO notice, Criteria cri, RedirectAttributes rttr) {
		
		return "";
	}
	
}
