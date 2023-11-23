package com.dgames.domain;

import java.util.Date;

import lombok.Data;

@Data
public class GameVO {
	
	private Integer game_id;			//게임 아이디
	private Integer platform_code;		//플랫폼 코드 (platform_tbl)연동
	private Integer genre_code;			//장르 코드 (genre_tbl)연동
	private Integer publisher_code;		//퍼블리셔 코드 (publisher_tbl)연동
	
	private String	game_title;			//게임명
	private int		game_price;			//게임 가격
	private int		game_discount;		//게임 할인율
	private String  game_description;	//게임 설명
	private String	game_language;		//지원 언어
	
	private String	img_up_folder;		//게임 이미지 업로드 폴더명 //별도 스프링처리
	private String	game_img;			//날짜폴더경로가 포함하여 파일이름저장 //별도 스프링 처리
	
	private String	game_status;		//게임 판매가능여부
	private Date	release_date;		//출시일
	
	
	
	
}
