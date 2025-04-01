package com.example.game.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ViewController {

	@GetMapping("/")
	public String home() {
		return "views/index";
	}
	
	@GetMapping("/views/**")
	public void goPage() {		// /WEB-INF /views/a/b/c/d/e/f.... .jsp 		
	}
}
