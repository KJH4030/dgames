package com.dgames.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewVO {

	// rew_num, mbsp_id, pro_num, rew_content, rew_score, rew_regdate
	
	private	Long	rev_num;
	private String	dgm_id;
	private	Integer game_id;
	private String	rev_content;
	private int		rev_score;
	private Date	rev_regdate;
}
