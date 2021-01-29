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
import com.ezen709.streetcat.service.MemberMapper;

public class chatHandler extends TextWebSocketHandler{
	@Autowired
	private LoginMapper loginMapper;
	@Autowired
	private MemberMapper memberMapper;
	
	Logger log = LoggerFactory.getLogger(chatHandler.class);
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	/*
	 * afterConnectionEstablished : �������� ����Ǹ� ȣ��Ǵ� �޼ҵ�
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		
		List<MemberDTO> list = loginMapper.loginListUp();
		String loginList = "loginList";
		for(int i = 0 ;i<list.size();i++) {
		  loginList = loginList +","+list.get(i).getUserId();
		}
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
		int count = memberMapper.getMessageCount(message.getPayload());
		session.sendMessage(new TextMessage("readMessage"+count));
        log.info("{}�� ���� {} ����", session.getId(), message.getPayload());

	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		Map<String, Object> ss = session.getAttributes();
		loginMapper.loginListOut((String)ss.get("mbId"));
		sessionList.remove(session);
		log.info(session.getId()+ "���� ����");
	}
}




