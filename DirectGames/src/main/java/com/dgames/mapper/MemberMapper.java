package com.dgames.mapper;

import com.dgames.domain.MemberVO;

public interface MemberMapper {
	
	String idCheck(String dgm_id);
	
	void regist(MemberVO vo);
}
