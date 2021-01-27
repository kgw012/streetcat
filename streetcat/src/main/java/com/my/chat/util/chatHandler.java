package com.my.chat.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.ezen709.streetcat.model.MemberDTO;
import com.ezen709.streetcat.service.LoginMapper;

public class chatHandler extends TextWebSocketHandler{
	@Autowired
	private LoginMapper loginMapper;
	
	Logger log = LoggerFactory.getLogger(chatHandler.class);
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	/*
	 * afterConnectionEstablished : �������� ����Ǹ� ȣ��Ǵ� �޼ҵ�
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		Map<String, Object> ss = session.getAttributes();
		System.out.println((String)ss.get("mbId")+"�α���");
		loginMapper.loginList((String)ss.get("mbId"));
		List<MemberDTO> list = loginMapper.loginListUp();
		String loginList = "loginList";
		for(int i = 0 ;i<list.size();i++) {
		  loginList = loginList +","+list.get(i).getUserId();
		  
		}
		System.out.println(loginList);
		sessionList.add(session);
		log.info(session.getId() + " ����� ");
		for(WebSocketSession se : sessionList) {
			se.sendMessage(new TextMessage(loginList));
			
		}
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
		Map<String, Object> ss = session.getAttributes();
		System.out.println((String)ss.get("mbId")+"�α׾ƿ�");
		loginMapper.loginListOut((String)ss.get("mbId"));
		sessionList.remove(session);
		log.info(session.getId()+ "���� ����");
	}
}



