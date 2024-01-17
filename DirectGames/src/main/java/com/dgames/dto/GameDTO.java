package com.dgames.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor // 모든 필드를 대상으로 매개변수가 있는 생성자메서드 생성
@Data
public class GameDTO {

	private Integer game_id;
	
	private	int game_price;
	private	String	game_status;
	
}
