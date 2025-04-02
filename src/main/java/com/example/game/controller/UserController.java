package com.example.game.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.game.service.UserService;
import com.example.game.vo.UserVO;

@Controller
public class UserController {
	@Autowired
	private UserService userService;
	
	@GetMapping("/user/list")
	public String getUsers(@ModelAttribute UserVO user, Model m) {
		List<UserVO> users = userService.selectUsers(user);
		m.addAttribute("users",users);
		return "views/user/user-list";
	}
	
	@GetMapping("/users")
	@ResponseBody
	public List<UserVO> getUsers(@ModelAttribute UserVO user) {
		return userService.selectUsers(user);
	}
}
