package com.dgames.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dgames.domain.GameVO;
import com.dgames.dto.Criteria;
import com.dgames.dto.GameDTO;

public interface AdGameMapper {

	void game_insert(GameVO vo);
	
	List<GameVO> game_list(Criteria cri);
	
	int getTotalCount(Criteria cri);
	
	// 파라미터가 2개이상 사용되는 경우 @Param 어노테이션 필수.
	// 방법1.
	void game_checked_modify1(
				@Param("game_id") Integer game_id,
				@Param("game_price") Integer game_price,
				@Param("game_status") String game_status
	);	
	// 방법2.
	void game_checked_modify2(List<GameDTO> game_modify_list);
	
	GameVO game_edit(Integer game_id);
	
	void game_delete(Integer game_id);
	
	void game_edit_ok(GameVO vo);
}
