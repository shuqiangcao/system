package com.test;

import java.io.*;

/**
 * @ClassName TxtTest1
 * @Description TODO
 * @Author caoshuqiang
 * @Date 2020/2/10 20:54
 */
public class TxtTest1 {
    public static void main(String[] args) {
        File file = new File("C:\\Users\\10396\\Desktop\\1.txt");
        StringBuilder result = new StringBuilder();
        try{
            BufferedReader br = new BufferedReader(new FileReader(file));//构造一个BufferedReader类来读取文件
            String s = null;
            int i = 1;
            while((s = br.readLine())!=null){//使用readLine方法，一次读一行
                i = i+1;
                result.append(System.lineSeparator()+s);
            }
            br.close();
            System.out.println(i);
            String s1 = result.toString();
            String[] split = s1.split(",");
            for (int j = 0; j < split.length; j++) {
                System.out.println(split[j]);
            }
            System.out.println(split.length);

        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
