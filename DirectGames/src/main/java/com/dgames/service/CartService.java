package com.dgames.service;

import java.util.List;

import com.dgames.domain.CartVO;
import com.dgames.dto.CartDTOList;

public interface CartService {

	Integer cart_check(Integer game_id, String dgm_id);

	void cart_add(CartVO vo);
	
	List<CartDTOList> cart_list(String dgm_id);
	
	void cart_list_del(Long cart_code);
	
	void cart_sel_delete(List<Long> cart_code_arr);

	void cart_empty();
}
