package com.lzm.anesdk.yeepay;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;

public final class YeepayUtils {

    public static final String ENCODE = "UTF-8";  //UTF-8
    
    public static String hmacSign(String aValue, String aKey) {
        byte k_ipad[] = new byte[64];
        byte k_opad[] = new byte[64];
        byte keyb[];
        byte value[];
        try
        {
            keyb = aKey.getBytes(ENCODE);
            value = aValue.getBytes(ENCODE);
        }
        catch(UnsupportedEncodingException e)
        {
            keyb = aKey.getBytes();
            value = aValue.getBytes();
        }
        Arrays.fill(k_ipad, keyb.length, 64, (byte)54);
        Arrays.fill(k_opad, keyb.length, 64, (byte)92);
        for(int i = 0; i < keyb.length; i++)
        {
            k_ipad[i] = (byte)(keyb[i] ^ 0x36);
            k_opad[i] = (byte)(keyb[i] ^ 0x5c);
        }

        MessageDigest md = null;
        try
        {
            md = MessageDigest.getInstance("MD5");
        }
        catch(NoSuchAlgorithmException e)
        {
        	e.printStackTrace();
            return null;
        }
        md.update(k_ipad);
        md.update(value);
        byte dg[] = md.digest();        
        md.reset();
        md.update(k_opad);
        md.update(dg, 0, 16);
        dg = md.digest();
        return toHex(dg);
    }
    
    public static String toHex(byte input[]) {
        if(input == null)
            return null;
        StringBuffer output = new StringBuffer(input.length * 2);
        for(int i = 0; i < input.length; i++){
            int current = input[i] & 0xff;
            if(current < 16)
                output.append("0");
            output.append(Integer.toString(current, 16));
        }

        return output.toString();
    }
    
}
