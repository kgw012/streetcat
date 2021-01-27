package com.my.chat.util;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;

import org.springframework.beans.factory.annotation.Autowired;

import com.ezen709.streetcat.service.CatBoardMapper;
import com.ezen709.streetcat.service.LoginMapper;

public class SessionChecker{
	
 public static int nowUser = 0;
 
 

    public void setSession(HttpSession session){
 // ������ ��ü�� �����ؼ� �̰͵� ���ǿ� ���� ��´�. 
        session.setAttribute("listener", new CustomBindingListener());
    }

public static void setNowUser(int x){
  nowUser += x;
 }
 public int getNowUser(){
  return this.nowUser;
 }
}

 

//                                                  

class CustomBindingListener implements HttpSessionBindingListener {
	
    public void valueBound(HttpSessionBindingEvent event) {
 // ������ ������ �� ����
    SessionChecker.setNowUser(1);
    System.out.println("BOUND as " + event.getName() + " to " + event.getSession().getId());
    }
    
    public void valueUnbound(HttpSessionBindingEvent event) {
 // ������ ����Ǿ�����
    	
   SessionChecker.setNowUser(-1);
        System.out.println("UNBOUND as " + event.getName() + " to " + event.getSession().getId());
    }
}
