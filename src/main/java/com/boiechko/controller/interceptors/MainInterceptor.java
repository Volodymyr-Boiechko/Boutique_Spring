package com.boiechko.controller.interceptors;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;

public class MainInterceptor extends HandlerInterceptorAdapter {


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        final HttpSession session = request.getSession();

        if (session.getAttribute("sex") == null) {
            session.setAttribute("sex", "manClothes");
        }
        if (session.getAttribute("idsOfProductsThatAreFavorite") == null){
            session.setAttribute("idsOfProductsThatAreFavorite", new ArrayList<>());
        }

        return true;
    }
}
