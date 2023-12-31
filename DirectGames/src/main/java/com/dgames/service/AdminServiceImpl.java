package com.dgames.service;

import org.springframework.stereotype.Service;

import com.dgames.domain.AdminVO;
import com.dgames.mapper.AdminMapper;

import lombok.RequiredArgsConstructor;

@Service // bean 생성 및 등록 : adminServiceImpl
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService {

	private final AdminMapper adminMapper;

	@Override
	public AdminVO admin_ok(String admin_id) {
		
		return adminMapper.admin_ok(admin_id);
	}

	@Override
	public void login_date(String admin_id) {
		
		adminMapper.login_date(admin_id);
		
	}
}
