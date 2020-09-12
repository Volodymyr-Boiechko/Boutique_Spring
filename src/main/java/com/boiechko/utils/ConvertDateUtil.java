package com.boiechko.utils;

import org.apache.log4j.Logger;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class ConvertDateUtil {

    private final static Logger logger = Logger.getLogger(ConvertDateUtil.class);

    public static Date convertDate(final String dateString) {

        final SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

        try {

            final java.util.Date dateUtil = format.parse(dateString);

            return new Date(dateUtil.getTime());

        } catch (ParseException e) {
            logger.error(e.getMessage());
            return null;
        }

    }

}
