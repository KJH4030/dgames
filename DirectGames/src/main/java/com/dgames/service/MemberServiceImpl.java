package com.dgames.service;

import org.springframework.stereotype.Service;

import com.dgames.domain.MemberVO;
import com.dgames.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

	private final MemberMapper memberMapper;

	@Override
	public String idCheck(String dgm_id) {
		
		return memberMapper.idCheck(dgm_id);
	}

	@Override
	public void regist(MemberVO vo) {
		
		memberMapper.regist(vo);
	}

	@Override
	public MemberVO login(String dgm_id) {
		
		return memberMapper.login(dgm_id);
	}

	@Override
	public void modify(MemberVO vo) {
		
		memberMapper.modify(vo);
	}
	
	
}
