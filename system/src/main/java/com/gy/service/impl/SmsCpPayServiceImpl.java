package com.gy.service.impl;

import com.gy.dao.SmsCpPayDao;
import com.gy.dto.Result;
import com.gy.entity.SmsCpConsume;
import com.gy.entity.SmsRechargeRecord;
import com.gy.service.SmsCpPayService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * @ClassName SmsCpPayServiceImpl
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/25 18:32
 **/
@Service
@Slf4j
public class SmsCpPayServiceImpl implements SmsCpPayService {

    @Autowired
    private SmsCpPayDao smsCpPayDao;

    @Override
    public Result queryPayList(Integer pageNum,Integer pageSize,String cp) {
        Result result = new Result();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String begintime = dateFormat.format(date);
        log.info("当前日期：{}",begintime);
        //获取后一天
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        int day = calendar.get(Calendar.DATE);
        calendar.set(Calendar.DATE,day+1);
        String endtime = dateFormat.format(calendar.getTime());
        int cppageSum = smsCpPayDao.findCppageSum(begintime, endtime,cp);
        int totalPage = 0;
        if (cppageSum % pageSize == 0){
            totalPage = cppageSum / pageSize;
        }else{
            totalPage = cppageSum / pageSize +1;
        }
        List<SmsRechargeRecord> payList = smsCpPayDao.findPayList(pageNum, pageSize, begintime, endtime, cp);
        result.setTotalPage(totalPage);
        result.setPageSize(pageSize);
        result.setCountNum(cppageSum);
        result.setPageNum(pageNum);
        result.setData(payList);
        return result;
    }

    @Override
    public Result queryCpPayList(Integer pageNum, Integer pageSize, String cp, String begintime, String endtime) {
        Result result = new Result();
        int cppageSum = smsCpPayDao.findCppageSum(begintime, endtime,cp);
        int totalPage = 0;
        if (cppageSum % pageSize == 0){
            totalPage = cppageSum / pageSize;
        }else{
            totalPage = cppageSum / pageSize +1;
        }
        List<SmsRechargeRecord> payList = smsCpPayDao.findPayList(pageNum, pageSize, begintime, endtime, cp);
        result.setTotalPage(totalPage);
        result.setPageSize(pageSize);
        result.setPageNum(pageNum);
        result.setCountNum(cppageSum);
        result.setData(payList);
        return result;
    }

    @Override
    public Result queryConsumeList(Integer pageNum, Integer pageSize, String cp) {
        Result result = new Result();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String begintime = dateFormat.format(date);
        log.info("当前日期：{}",begintime);
        //获取后一天
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        int day = calendar.get(Calendar.DATE);
        calendar.set(Calendar.DATE,day+1);
        String endtime = dateFormat.format(calendar.getTime());
        int consumepageSum = smsCpPayDao.findConsumepageSum(begintime, endtime,cp);
        int totalPage = 0;
        if (consumepageSum % pageSize == 0){
            totalPage = consumepageSum / pageSize;
        }else{
            totalPage = consumepageSum / pageSize +1;
        }
        List<SmsCpConsume> payList = smsCpPayDao.findConsumeList(pageNum, pageSize, begintime, endtime, cp);
        result.setPageSize(pageSize);
        result.setTotalPage(totalPage);
        result.setPageNum(pageNum);
        result.setCountNum(consumepageSum);
        result.setData(payList);
        return result;
    }

    @Override
    public Result queryCpConsumeList(Integer pageNum, Integer pageSize, String cp, String begintime, String endtime) {
        Result result = new Result();
        int consumepageSum = smsCpPayDao.findConsumepageSum(begintime, endtime,cp);
        int totalPage = 0;
        if (consumepageSum % pageSize == 0){
            totalPage = consumepageSum / pageSize;
        }else{
            totalPage = consumepageSum / pageSize +1;
        }
        List<SmsCpConsume> consumeList = smsCpPayDao.findConsumeList(pageNum, pageSize, begintime, endtime, cp);
        result.setPageSize(pageSize);
        result.setTotalPage(totalPage);
        result.setPageNum(pageNum);
        result.setCountNum(consumepageSum);
        result.setData(consumeList);
        return result;
    }
}
