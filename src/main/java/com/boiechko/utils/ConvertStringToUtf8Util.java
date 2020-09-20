package com.boiechko.utils;

import java.nio.charset.StandardCharsets;

public class ConvertStringToUtf8Util {

    public static String convert(final String s) {
        return new String(s.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
    }

}
