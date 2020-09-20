package com.boiechko.controller.interceptors;

import com.boiechko.model.Product;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashSet;

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
        if (session.getAttribute("shoppingBag") == null) {
            session.setAttribute("shoppingBag", new HashSet<Product>());
        }

        return true;
    }
}
