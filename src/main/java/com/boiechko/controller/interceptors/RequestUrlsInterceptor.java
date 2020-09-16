package com.boiechko.controller.interceptors;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Arrays;

public class RequestUrlsInterceptor extends HandlerInterceptorAdapter {

    private final String[] loginRequiredUrls = {"/userProfile"};
    private final String[] pagesComponentsUrls = {"/footer", "/header", "/navProfile"};
    private final String[] authenticationUrls = {"/login", "/registration", "/forgetPassword"};

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        final HttpSession session = request.getSession();
        final boolean isUserLoggedIn = (session != null && session.getAttribute("user") != null);

        final String requestUri = request.getRequestURI();
        final boolean isAuthenticationRequest = Arrays.asList(authenticationUrls).contains(requestUri);

        if (isUserLoggedIn && isAuthenticationRequest) {
            // the user is already logged in and he's trying to get authentication pages again
            // then redirect to the homePage
            response.sendRedirect("/");
            return false;
        } else if (isContainsUrls(request, pagesComponentsUrls)) {
            // user tried to visit components of pages
            // redirect to the homePage
            response.sendRedirect("/");
            return false;
        } else if (!isUserLoggedIn && isContainsUrls(request, loginRequiredUrls)) {
            // user isn't logged in and the requested page requires authentication,
            // then redirect to the login page
            response.sendRedirect("/login");
            return false;
        } else {
            // for other requested pages continue to the destination
            return true;
        }

    }

    private boolean isContainsUrls(final HttpServletRequest request, final String[] urlStrings) {

        return Arrays.stream(urlStrings)
                .anyMatch(request.getRequestURL().toString()::contains);
    }
}
