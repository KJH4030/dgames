package com.dgames.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dgames.domain.CartVO;
import com.dgames.dto.CartDTOList;

// DAO 의미와 동일.
public interface CartMapper {

	Integer cart_check(@Param("game_id") Integer game_id, @Param("dgm_id") String dgm_id);
	
	void cart_add(CartVO vo);
	
	List<CartDTOList> cart_list(String dgm_id);
	
	void cart_list_del(Long cart_code);
	
	//장바구니 선택삭제. 파라미터 List컬렉션 사용.
	void cart_sel_delete(List<Long> cart_code_arr);
	
	void cart_empty();
	
}
