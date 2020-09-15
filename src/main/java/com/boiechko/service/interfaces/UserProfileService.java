package com.boiechko.service.interfaces;

import javax.servlet.http.HttpServletRequest;

public interface UserProfileService {

    int getNumberOfSectionInNavigationBar(final HttpServletRequest request);

}
