package com.gy.service;

import com.gy.dto.Result;

/**
 * @ClassName UrlService
 * @Description: TODO
 * @Author 曹树强
 * @Date 2020/1/15 18:05
 **/
public interface UrlService {
    public Result addBatchUrl(String longurl);

    public Result addallBatchUrl(String longurl, String mobile);
}
