package com.example.game.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.game.controller.ViewController;
import com.example.game.mapper.UserMapper;
import com.example.game.vo.UserVO;

@Service
public class UserService {

	@Autowired
	private UserMapper userMapper;


	public List<UserVO> selectUsers(UserVO user){
		return userMapper.selectUsers(user);
	}
	
	public UserVO selectUser(int uiNum){
		return userMapper.selectUser(uiNum);
	}
	
	public int insertUser(UserVO user){
		return userMapper.insertUser(user);
	}
	
	public int updateUser(UserVO user){
		return userMapper.updateUser(user);
	}
	
	public int deleteUser(int uiNum){
		return userMapper.deleteUser(uiNum);
	}
}
