package com.dgames.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dgames.domain.NoticeVO;
import com.dgames.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;


@RequestMapping("/board/*")
@Log4j
@RequiredArgsConstructor
@Controller
public class BoardController {
	
	private final BoardService boardService;

	@GetMapping("/ntc_list")
	public void ntc_list() {
		
	}
	
	@GetMapping("/ntc_regist")
	public void ntc_regist() {
		
	}
	
	@PostMapping("/ntc_regist")
	public String ntc_Regist(NoticeVO noticeVO) {
		
		boardService.ntc_regist(noticeVO);
		
		return "redirect:/board/ntc_list";
	}
	
}
