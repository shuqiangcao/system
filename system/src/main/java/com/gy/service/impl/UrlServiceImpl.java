package com.gy.service.impl;

import com.gy.dao.UrlDao;
import com.gy.dto.Result;
import com.gy.entity.ShortUrl;
import com.gy.service.UrlService;
import com.gy.util.BatchChangeUrl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

/**
 * @ClassName UrlServiceImpl
 * @Description: TODO
 * @Author 曹树强
 * @Date 2020/1/15 18:05
 **/
@Service
@Slf4j
public class UrlServiceImpl implements UrlService {

    @Autowired
    UrlDao urlDao;

    @Override
    public Result addBatchUrl(String longurl) {
        Result result = new Result();
//        try{
//            String[] mobileStr = mobile.split(",");
//            int mobileSum = mobileStr.length;
//            log.info("号码数:{}",mobileSum);
//            List<ShortUrl> shortUrls = new ArrayList<ShortUrl>();
//            int j = 0;
//            for (int i =0;i < mobileSum;i++){
//                ShortUrl shortUrl = new ShortUrl();
//                String string = BatchChangeUrl.shortUrl(longurl, mobileStr[i]);
//                shortUrl.setParam(string);
//                shortUrl.setLongUrl(longurl);
//                shortUrl.setMobile(mobileStr[i]);
//                shortUrl.setShortUrl("b.guoqinwl.cn/?b="+string+"");
//                shortUrls.add(shortUrl);
//                if (i % 500 == 0 && i != 0){
//                    log.info("执行插入....");
//                    int insertNum =  urlDao.insertMobileUrl(shortUrls);
//                    j = j+insertNum;
//                    shortUrls.clear();
//                }
//            }
//            log.info("最后一次执行插入....");
//            int i = urlDao.insertMobileUrl(shortUrls);
//            j = j +i;
//            log.info("生成链接数:{}",j);
//            if (j == mobileSum){
//                result.setSuccess(true);
//            }
//        }catch (Exception e){
//            e.printStackTrace();
//        }
        try{
            String shortStr = BatchChangeUrl.shortUrl(longurl);
            String shortUrlStr = "http://b.guoqinwl.cn/?b="+shortStr;

            URL u =new URL("http://www.sinadwz.cn/tcn/api?key=2hG1ANq6ib&url="+shortUrlStr+"");
            InputStream in = u.openStream();
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            try {
                byte buf[] = new byte[1024];
                int read = 0;
                while ((read = in .read(buf)) > 0) {
                    out.write(buf, 0, read);
                }
            } finally {
                if ( in != null) {
                    in .close();
                }
            }
            byte b[] = out.toByteArray();
            String sinaurl = new String(b, "utf-8");
            sinaurl = sinaurl.substring(8);
            ShortUrl shortUrl = new ShortUrl();
            shortUrl.setLongUrl(longurl);
            shortUrl.setShortUrl(shortUrlStr);
            shortUrl.setParam(shortStr);
            shortUrl.setSinaUrl(sinaurl);
            int i = urlDao.insertData(shortUrl);
            if ( i == 1){
                result.setSuccess(true);
                result.setData(sinaurl);
            }

        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

    @Override
    public Result addallBatchUrl(String longurl, String mobile) {
        Result result = new Result();
        try{
            ShortUrl findshorturl = urlDao.findshorturl(longurl);
            String[] mobileStr = mobile.split(",");
            int mobileSum = mobileStr.length;
            log.info("号码数:{}",mobileSum);
            List<ShortUrl> shortUrls = new ArrayList<ShortUrl>();
            int j = 0;
            for (int i =0;i < mobileSum;i++){
                ShortUrl shortUrl = new ShortUrl();
                shortUrl.setParam(findshorturl.getParam());
                shortUrl.setLongUrl(longurl);
                shortUrl.setMobile(mobileStr[i]);
                shortUrl.setShortUrl(findshorturl.getSinaUrl());
                shortUrls.add(shortUrl);
                if (i % 500 == 0 && i != 0){
                    log.info("执行插入....");
                    int insertNum =  urlDao.insertMobileUrl(shortUrls);
                    j = j+insertNum;
                    shortUrls.clear();
                }
            }
            log.info("最后一次执行插入....");
            int i = urlDao.insertMobileUrl(shortUrls);
            j = j +i;
            log.info("生成链接数:{}",j);
            if (j == mobileSum){
                result.setSuccess(true);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }
}
