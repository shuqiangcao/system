package com.gy.dao;

import com.gy.entity.ShortUrl;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @ClassName UrlDao
 * @Description: TODO
 * @Author 曹树强
 * @Date 2020/1/15 18:07
 **/
public interface UrlDao {
    public int insertMobileUrl(@Param("shortUrls") List<ShortUrl> shortUrls);

    public int insertData(ShortUrl shortUrl);

    public int updateUrl(@Param("sinaurl") String sinaurl,@Param("shorturl") String longurl);

    int insertallurlData(ShortUrl shortUrl);

    public ShortUrl findshorturl(String longurl);
}
