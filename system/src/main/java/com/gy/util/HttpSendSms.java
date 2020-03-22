package com.gy.util;

import lombok.extern.slf4j.Slf4j;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ByteArrayEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

/**
 * @ClassName HttpSendSms
 * @Description: 请求发送短信
 * @Author 曹树强
 * @Date 2019/12/31 10:16
 **/
@Slf4j
public class HttpSendSms {

    public static String sendSms(String param){
        log.info(param);
        String res = "1";
        try{
            String posturl = "http://120.24.90.245:9991";
            log.info("发送地址:{}",posturl);
            CloseableHttpClient httpClient = HttpClients.createDefault();
            HttpPost httpPost = new HttpPost(posturl);
            httpPost.setHeader("Charset", "UTF-8");
            httpPost.setHeader("Content-Type", "application/json");
            httpPost.setEntity(new ByteArrayEntity(param.getBytes("UTF-8")));
            CloseableHttpResponse resp = httpClient.execute(httpPost);
            Integer backcode = resp.getStatusLine().getStatusCode();
            log.info("状态码:{}",String.valueOf(backcode));
            if(resp != null && backcode == 200){
                HttpEntity entity = resp.getEntity();
                res = EntityUtils.toString(entity);
                log.info("提交返回:{}",res);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return  res;
    }

}
