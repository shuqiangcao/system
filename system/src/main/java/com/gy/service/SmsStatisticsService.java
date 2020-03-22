package com.gy.service;

import com.gy.dto.Result;
import com.gy.entity.SmsChannel;
import com.gy.entity.SmsNotify;
import org.apache.http.HttpResponse;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * @ClassName SmsStatisticsService
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/19 11:12
 **/
public interface SmsStatisticsService {
    public Result queryAllrecord(Integer pageNum, Integer pageSize,String cpName);

    public Result queryRecord(Integer pageNum, Integer pageSize, String cp, String begintime, String endtime);

    public Result querySendCount(Integer pageNum, Integer pageSize, String begintime, String endtime,String cpName);

    public Result querySmsSubmit(Integer pageNum, Integer pageSize, String begintime, String endtime,String cpName);

    public Result queryCpSmsSubmit(String cp, String channel, String byway, Integer pageNum, Integer pageSize, String begintime, String endtime);

    public List<SmsChannel> queryChannel();

    public Result querySendCountByWay(String cp, String channel, String byway, Integer pageNum, Integer pageSize, String begintime, String endtime);

    public Result querySmsSuccess(Integer pageNum, Integer pageSize, String begintime, String endtime,String cpName);

    public Result querySmsSuccByWay(String cp, String channel, String byway, Integer pageNum, Integer pageSize, String begintime, String endtime);

    public Result querySmsFail(Integer pageNum, Integer pageSize, String begintime, String endtime,String cpName);

    public Result querySmsFailByWay(String cp, String channel, String byway, Integer pageNum, Integer pageSize, String begintime, String endtime);

    public Result querySmsstatus(String mobile, Integer pageNum, Integer pageSize, String begintime, String endtime,String cpName);

    public Result querySmsInfoMsg(String infoId, Integer pageNum, Integer pageSize);

    public Result checkSmsInfoMsg(String infoId, String resultstatus, String mobile, Integer pageNum, Integer pageSize);

    public Result querySmsSendCount(Integer pageNum, Integer pageSize, String begintime, String endtime, String cpName);

    public Result querySmsSendCountByWay(String cp, String channel, String byway, Integer pageNum, Integer pageSize, String begintime, String endtime);

    public Result queryMobileFilter(String infoId);

    public List<SmsNotify> exportMobileMsg(String infoId);
}
