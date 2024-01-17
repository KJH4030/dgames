package com.dgames.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dgames.domain.GameVO;
import com.dgames.domain.NoticeVO;
import com.dgames.dto.Criteria;
import com.dgames.dto.PageDTO;
import com.dgames.service.BoardService;
import com.dgames.service.UserGameService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

/**
 * Handles requests for the application home page.
 */
@Log4j
@RequiredArgsConstructor
@Controller
public class HomeController {
	
	private final UserGameService userGameService;
	private final BoardService boardService;	

	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Criteria cri, Model model) {		

		cri.setAmount(5);
		
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
		
		cri.setAmount(3);
		
		List<GameVO> game_list = userGameService.game_list(cri);
		
		//날짜 폴더의 역슬래시를 슬래시로 바꾸는 작업. 역슬래시로 되어있는 정보가 스프링으로 보내는 요청데이터에 사용되면 에러발생
		game_list.forEach(vo -> {
			vo.setImg_up_folder(vo.getImg_up_folder().replace("\\", "/"));
		});
		model.addAttribute("game_list", game_list);
		
		int totalCount = userGameService.getTotalCount();
		model.addAttribute("pageMaker", new PageDTO(cri,totalCount));	
		
		return "index";
	}
	
}
