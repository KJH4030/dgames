package com.dgames.mapper;

import com.dgames.domain.MemberVO;

public interface MemberMapper {
	
	String idCheck(String dgm_id);
	
	void regist(MemberVO vo);
	
	MemberVO login(String dgm_id);
	
	void modify(MemberVO vo);
}
