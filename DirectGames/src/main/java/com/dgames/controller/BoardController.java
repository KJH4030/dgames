package com.dgames.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;


@RequestMapping("/board/**")
@Log4j
@RequiredArgsConstructor
@Controller
public class BoardController {

	@GetMapping("/list")
	public void list() {
		
	}
}
