package com.dgames.dto;

import lombok.Data;

@Data
public class CartDTOList {

	// c.cart_code, c.pro_num,c.cart_amount, p.pro_name, p.pro_price, p.pro_img, p.pro_discount, p.pro_up_folder
	
	private Long cart_code;
	private Integer game_id;
	
	private	String	game_title;
	private	int		game_price;
	private	String	img_up_folder;  // 스프링에서 별도로 처리
	private	String	game_img;	// // 스프링에서 별도로 처리
	private	int		game_discount;
	
	
}
