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
 // 리스너 객체를 생성해서 이것도 세션에 같이 담는다. 
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
 // 세션이 생겼을 할 내용
    SessionChecker.setNowUser(1);
    System.out.println("BOUND as " + event.getName() + " to " + event.getSession().getId());
    }
    
    public void valueUnbound(HttpSessionBindingEvent event) {
 // 세션이 종료되었을때
    	
   SessionChecker.setNowUser(-1);
        System.out.println("UNBOUND as " + event.getName() + " to " + event.getSession().getId());
    }
}
