package com.example.game.config;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.web.socket.messaging.AbstractSubProtocolEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

import com.example.game.service.BingoService;

import lombok.extern.slf4j.Slf4j;

@Configuration
@Slf4j
public class WebSocketHandler{
	@Autowired
	private SimpMessagingTemplate smt;

	@EventListener
	public void handleSessionDisconnect(SessionDisconnectEvent event) {
		String sessionId = getSessionId(event);
		log.info("sessionId=>{}", sessionId);
		BingoService.removeSessionId(sessionId);
		Map<String,String> map = new HashMap<>();
		map.put("type", "exit");
		map.put("sessionId", sessionId);
		smt.convertAndSend("/topic/visite", map);
	}

	public String getSessionId(AbstractSubProtocolEvent event) {
		StompHeaderAccessor header = StompHeaderAccessor.wrap(event.getMessage());
		return header.getSessionId();
	}
}
