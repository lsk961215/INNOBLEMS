package com.spring.innoblems.aop;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

public class SHA256 {
	public SHA256() {
    }

	// 0)
    public static String createSalt(String plainText) throws NoSuchAlgorithmException {
        SecureRandom random = SecureRandom.getInstance("SHA1PRNG");
        byte [] bytes = new byte[16];
        random.nextBytes(bytes);

        //SALT 생성
        String salt = new String(Base64.getEncoder().encode(bytes));

        //System.out.println("{SHA256.Class} salt : " + salt);
        return salt;
    }

    public static String encrypt(String plainText, String salt) {
        try {
            // 1) 
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            String rawAndSalt = plainText + salt;
            //System.out.println("{SHA256.Class} rawAndSalt : " + rawAndSalt);

            // 2) 
            md.update(rawAndSalt.getBytes());

            // 3) 
            byte[] byteData = md.digest(); // 1byte = 8bit

            // 4)
            StringBuffer hexString = new StringBuffer();
            for(int i = 0; i < byteData.length; ++i) {
                String hex = Integer.toHexString(255 & byteData[i]);
                if (hex.length() == 1) {
                    hexString.append('0');// 각 byteData당 두 자리 수 16진수로 변환
                }
                hexString.append(hex);
            }

            return hexString.toString();

        } catch (Exception var7) {
            var7.printStackTrace();
            throw new RuntimeException();
        }
    }
}
