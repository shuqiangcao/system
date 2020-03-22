package com.test;

import java.io.*;

/**
 * @ClassName TxtTest
 * @Description TODO
 * @Author caoshuqiang
 * @Date 2020/2/10 19:42
 */
public class TxtTest {
    public static void main(String[] args) {
        File file = new File("C:\\Users\\caoshuqiang\\Desktop\\2.txt");
        StringBuilder result = new StringBuilder();
        try{
            BufferedReader br = new BufferedReader(new FileReader(file));//构造一个BufferedReader类来读取文件
            String s = null;
            while((s = br.readLine())!=null){//使用readLine方法，一次读一行
                result.append(System.lineSeparator()+s);
            }
            br.close();
            String s1 = result.toString();
            String[] split = s1.split(",");
            File file1 = new File("C:\\Users\\caoshuqiang\\Desktop\\1.txt");
            int j = 1;
            BufferedWriter out = new BufferedWriter(new FileWriter(file1));
            for (int i = 0; i < split.length ; i++) {
                out.write(split[i]+"\r\n");
                if (i % 30000 == 0 && i != 0){
                    j = j+1;
                    System.out.println(i);
                    out.flush(); // 把缓存区内容压入文件
                    File filenew = new File("C:\\Users\\caoshuqiang\\Desktop\\"+j+".txt");
                    if (!filenew.exists()) {
                        try {
                            filenew.createNewFile();
                            out = new BufferedWriter(new FileWriter(filenew));
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }

                }
               // System.out.println(split[i]);
            }
            out.close();
            System.out.println(split.length);

        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
