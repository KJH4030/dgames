package com.dgames.domain;

import java.util.Date;

import lombok.Data;

@Data
public class NoticeVO {

	private Long ntc_id;
	
	private String ntc_cat;
	private String ntc_title;
	private String ntc_content;
	
	private Date ntc_regdate;
	private Date ntc_mdfdate;
	
	private String ntc_up_folder;
	private String ntc_img;
	
	private int ntc_views;	
	
}
