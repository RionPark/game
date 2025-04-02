package com.example.game.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import com.example.game.vo.MessageVO;

@Controller
public class ChatController {

	@MessageMapping("/message")
	@SendTo("/topic/message")
	public MessageVO handleMessage(MessageVO message) {
		return message;
	}
}
