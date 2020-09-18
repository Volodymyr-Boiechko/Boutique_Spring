package com.boiechko.controller.interceptors;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MainInterceptor extends HandlerInterceptorAdapter {


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        final HttpSession session = request.getSession();

        if (session.getAttribute("sex") == null) {
            session.setAttribute("sex", "manClothes");
        }


        return true;
    }
}
