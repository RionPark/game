package com.example.game.mapper;

import java.util.List;

import com.example.game.vo.UserVO;

public interface UserMapper {
	List<UserVO> selectUsers(UserVO user);
	UserVO selectUser(int uiNum);
	UserVO selectUserById(UserVO user);
	int insertUser(UserVO user);
	int updateUser(UserVO user);
	int deleteUser(int uiNum);
}
