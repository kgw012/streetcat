package com.my.chat.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class chatHandler extends TextWebSocketHandler{
	
	Logger log = LoggerFactory.getLogger(chatHandler.class);
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	/*
	 * afterConnectionEstablished : 웹소켓이 연결되면 호출되는 메소드
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		sessionList.add(session);
		log.info(session.getId() + " 연결됨 ");
		
	}
	
	/*
	 * handleTextMessage : 클라이언트가 메세지 전송 시 호출되는 메소드 
	 */
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		for(WebSocketSession se : sessionList) {
			se.sendMessage(new TextMessage(message.getPayload()));
		}
		
        log.info("{}로 부터 {} 받음", session.getId(), message.getPayload());

	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
		log.info(session.getId()+ "연결 종료");
	}
}


