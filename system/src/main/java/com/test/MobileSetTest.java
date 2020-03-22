package com.test;

import java.util.HashSet;
import java.util.Set;

/**
 * @ClassName MobileSetTest
 * @Description: TODO
 * @Author 曹树强
 * @Date 2020/1/13 15:43
 **/
public class MobileSetTest {
    public static void main(String[] args) {
        long be = System.currentTimeMillis();
        Set set = new HashSet();
        for (int i = 0; i < 1000000; i ++){
            set.add(i);
        }
        int a = set.size();
        for (int i = 0; i < 1000000; i ++){
            set.add(i);
        }
        int b = set.size();
        long en = System.currentTimeMillis();
        System.out.println(en-be);
        System.out.println(a);
        System.out.println(b);
    }
}
