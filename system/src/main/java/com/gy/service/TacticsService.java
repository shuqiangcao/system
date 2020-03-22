package com.gy.service;

import com.gy.dto.Result;

/**
 * @ClassName StacticsService
 * @Description: TODO
 * @Author 曹树强
 * @Date 2020/1/11 14:34
 **/
public interface TacticsService {
    public Result queryMaskword(String maskword);

    public Result insertMaskword(String maskword);
}
