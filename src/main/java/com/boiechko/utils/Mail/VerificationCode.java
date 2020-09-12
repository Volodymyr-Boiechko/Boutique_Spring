package com.boiechko.utils.Mail;

import java.util.Random;

public class VerificationCode {

    public static String generateCode() {

        final byte[] byteArray = new byte[8];

        for (int i = 0; i < byteArray.length; i++) {
            byteArray[i] = generateRandomByte();
        }

        for (int i = 1; i < byteArray.length; i++) {

            if (byteArray[i - 1] == byteArray[i]) {

                do {
                    byteArray[i - 1] = generateRandomByte();
                } while (byteArray[i - 1] == byteArray[i]);
            }
        }

        return new String(byteArray);
    }

    // digits 0-9 and all upper- and lowercase letters
    private static byte generateRandomByte() {

        final byte[] mapByteArray = {0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39,
                0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d,
                0x4e, 0x4f, 0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5a,
                0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d,
                0x6e, 0x6f, 0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7a
        };

        final Random random = new Random();

        return mapByteArray[random.nextInt(62)];
    }

}
