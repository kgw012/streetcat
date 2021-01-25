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
	 * afterConnectionEstablished : �������� ����Ǹ� ȣ��Ǵ� �޼ҵ�
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		sessionList.add(session);
		log.info(session.getId() + " ����� ");
		
	}
	
	/*
	 * handleTextMessage : Ŭ���̾�Ʈ�� �޼��� ���� �� ȣ��Ǵ� �޼ҵ� 
	 */
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		for(WebSocketSession se : sessionList) {
			se.sendMessage(new TextMessage(message.getPayload()));
		}
		
        log.info("{}�� ���� {} ����", session.getId(), message.getPayload());

	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
		log.info(session.getId()+ "���� ����");
	}
}


