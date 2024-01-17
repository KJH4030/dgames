package com.dgames.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.dgames.domain.GameVO;
import com.dgames.dto.Criteria;
import com.dgames.dto.GameDTO;
import com.dgames.mapper.AdGameMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdGameServiceImpl implements AdGameService {

	private final AdGameMapper adGameMapper;

	@Override
	public void game_insert(GameVO vo) {

		adGameMapper.game_insert(vo);
		
	}

	@Override
	public List<GameVO> game_list(Criteria cri) {
		return adGameMapper.game_list(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		return adGameMapper.getTotalCount(cri);
	}

	@Override
	public GameVO game_edit(Integer game_id) {
		return adGameMapper.game_edit(game_id);
	}

	@Override
	public void game_checked_modify1(List<Integer> game_id_arr, List<Integer> game_price_arr, List<String> game_status_arr) {
		
		// db의 연동작업이 size만큼 진행이된다.
		// Connectiion Open -> mapper.xml sql구문실행 -> Connectiion Close
		for(int i=0; i<game_id_arr.size(); i++) {
			adGameMapper.game_checked_modify1(game_id_arr.get(i), game_price_arr.get(i), game_status_arr.get(i));
		}
		
	}

	@Override
	public void game_checked_modify2(List<Integer> game_id_arr, List<Integer> game_price_arr, List<String> game_status_arr) {
		// TODO Auto-generated method stub
		List<GameDTO> game_modify_list = new ArrayList<GameDTO>();
		
		for(int i=0; i<game_id_arr.size(); i++) {
			GameDTO gameDTO = new GameDTO(game_id_arr.get(i), game_price_arr.get(i), game_status_arr.get(i));
			game_modify_list.add(gameDTO);
		}
		
		adGameMapper.game_checked_modify2(game_modify_list);
		
	}

	@Override
	public void game_delete(Integer game_id) {
		
		adGameMapper.game_delete(game_id);
	}

	@Override
	public void game_edit(GameVO vo) {
		
		adGameMapper.game_edit_ok(vo);
		
	}
}
