package com.gy.service;

import com.gy.dto.Result;

/**
 * @ClassName SmsCpPayService
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/25 18:31
 **/
public interface SmsCpPayService {
    public Result queryPayList(Integer pageNum,Integer pageSize,String cp);

    public Result queryCpPayList(Integer pageNum, Integer pageSize, String cp, String begintime, String endtime);

    public Result queryConsumeList(Integer pageNum, Integer pageSize, String cp);

    public Result queryCpConsumeList(Integer pageNum, Integer pageSize, String cp, String begintime, String endtime);
}
