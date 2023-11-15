package com.dgames.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	@GetMapping("/notice/ntc_get")
	public void get(@RequestParam("ntc_id") Long ntc_id, @ModelAttribute("cri") Criteria cri,  Model model) {
		
		log.info("게시물 번호 :" + ntc_id);
		log.info("페이지, 검색 정보 :" + cri);
		
		NoticeVO notice = boardService.ntc_get(ntc_id);
		model.addAttribute("notice",notice);
	}
	
}
