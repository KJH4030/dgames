package com.dgames.service;

import java.util.List;

import com.dgames.domain.GameVO;
import com.dgames.dto.Criteria;

public interface AdGameService {

	void game_insert(GameVO vo);
	
	List<GameVO> game_list(Criteria cri);
	
	int getTotalCount(Criteria cri);
	
	void game_checked_modify1(List<Integer> game_id_arr, List<Integer> game_price_arr, List<String> game_status_arr);
	
	void game_checked_modify2(List<Integer> game_id_arr, List<Integer> game_price_arr, List<String> game_status_arr);
	
	GameVO game_edit(Integer game_id);
	
	void game_edit(GameVO vo);
	
	void game_delete(Integer game_id);
	
	
}
