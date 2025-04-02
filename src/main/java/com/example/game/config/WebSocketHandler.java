package com.example.game.config;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.EventListener;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.messaging.Message;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.web.socket.messaging.AbstractSubProtocolEvent;
import org.springframework.web.socket.messaging.SessionConnectedEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;
import org.springframework.web.socket.server.HandshakeFailureException;
import org.springframework.web.socket.server.HandshakeHandler;

import com.example.game.controller.BingoController;
import com.example.game.vo.MessageVO;

import lombok.extern.slf4j.Slf4j;

@Configuration
@Slf4j
public class WebSocketHandler implements HandshakeHandler{
	@Autowired
	private SimpMessagingTemplate smt;

	@EventListener
	public void handleSessionDisconnect(SessionDisconnectEvent event) {
		String sessionId = getSessionId(event);
	}

	@EventListener
	public void handleWebSocketConnectListener(SessionConnectedEvent event) {
		String name = getName(event);
		String sessionId = getSessionId(event);
		String destincation = getDestination(event);
	}

	public String getSessionId(AbstractSubProtocolEvent event) {
		StompHeaderAccessor header = StompHeaderAccessor.wrap(event.getMessage());
		return header.getSessionId();
	}
	public String getDestination(AbstractSubProtocolEvent event) {
		StompHeaderAccessor header = StompHeaderAccessor.wrap(event.getMessage());
		return header.getDestination();
	}
	public String getName(AbstractSubProtocolEvent event) {
		StompHeaderAccessor header = StompHeaderAccessor.wrap(event.getMessage());
		Message<?> message = header.getMessageHeaders().get(SimpMessageHeaderAccessor.CONNECT_MESSAGE_HEADER, Message.class);
		StompHeaderAccessor messageHeader = StompHeaderAccessor.wrap(message);
		return messageHeader.getFirstNativeHeader("username");
	}

	@Override
	public boolean doHandshake(ServerHttpRequest request, ServerHttpResponse response,
			org.springframework.web.socket.WebSocketHandler wsHandler, Map<String, Object> attributes)
			throws HandshakeFailureException {
		// TODO Auto-generated method stub
		return false;
	}
}
