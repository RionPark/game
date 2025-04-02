package com.example.game.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.example.game.service.BingoService;
import com.example.game.vo.ErrorVO;
import com.example.game.vo.MessageVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class BingoController {
	@Autowired
	private SimpMessagingTemplate smt;

	@MessageMapping("/bingo")
	@SendTo("/topic/bingo")
	public MessageVO bingo(MessageVO message) {
		return message;
	}
	
	@MessageMapping("/check/{name}")
	public void checkName(@DestinationVariable("name") String name, @Header("simpSessionId") String sessionId) {
		log.info("name=>{}", name);
		if(BingoService.isExisteName(name)) {
			ErrorVO error = new ErrorVO();
			error.setErrorCode(1);
			error.setErrorMsg(name + "은 이미 존재하는 이름입니다.");
			smt.convertAndSend("/topic/check/" + name, error);
			return;
		}
		BingoService.addSession(sessionId, name);
		smt.convertAndSend("/topic/check/" + name, BingoService.getBingoSession());
	}
	
	
}
