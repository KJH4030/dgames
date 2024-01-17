package com.dgames.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dgames.domain.CartVO;
import com.dgames.dto.CartDTOList;
import com.dgames.mapper.CartMapper;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class CartServiceImpl implements CartService {
	
	private final CartMapper cartMapper;

	@Override
	public Integer cart_check(Integer game_id, String dgm_id) {
		// TODO Auto-generated method stub
		return cartMapper.cart_check(game_id, dgm_id);
	}

	@Override
	public void cart_add(CartVO vo) {
		// TODO Auto-generated method stub
		cartMapper.cart_add(vo);
	}

	@Override
	public List<CartDTOList> cart_list(String dgm_id) {
		// TODO Auto-generated method stub
		return cartMapper.cart_list(dgm_id);
	}
	@Override
	public void cart_list_del(Long cart_code) {
		// TODO Auto-generated method stub
		cartMapper.cart_list_del(cart_code);
	}

	@Override
	public void cart_sel_delete(List<Long> cart_code_arr) {
		// TODO Auto-generated method stub
		cartMapper.cart_sel_delete(cart_code_arr);
	}

	@Override
	public void cart_empty() {

		cartMapper.cart_empty();
		
	}
}
