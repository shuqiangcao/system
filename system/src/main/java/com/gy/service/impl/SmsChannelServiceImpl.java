package com.gy.service.impl;

import com.gy.dao.SmsChannelDao;
import com.gy.dto.Result;
import com.gy.entity.SmsChannel;
import com.gy.service.SmsChannelService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @ClassName SmsChannelServiceImpl
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/16 14:52
 **/
@Service
@Slf4j
public class SmsChannelServiceImpl implements SmsChannelService {

    @Autowired
    private SmsChannelDao smsChannelDao;

    @Override
    public Result queryAllChannel(Integer pageNum, Integer pageSize) {
        Result result = new Result();
        int pageSum = smsChannelDao.findchannelPageSum();
        int totalPage = 0;
        if (pageSum % pageSize == 0){
            totalPage = pageSum / pageSize;
        }else{
            totalPage = pageSum / pageSize +1;
        }
        List<SmsChannel> allChannel = smsChannelDao.findAllChannel(pageNum,pageSize);
        result.setPageNum(pageNum);
        result.setPageSize(pageSize);
        result.setCountNum(pageSum);
        result.setTotalPage(totalPage);
        result.setData(allChannel);
        return result;
    }

    @Override
    public Result insertChannel(SmsChannel smsChannel) {
        Result result = new Result();
        SmsChannel channelByNameAndaccount = smsChannelDao.findChannelByNameAndaccount(smsChannel.getName(),smsChannel.getAccount());
        if (channelByNameAndaccount != null){
            result.setSuccess(false);
            result.setRepeatChannel(true);
            return  result;
        }else{
            int i = smsChannelDao.saveChannel(smsChannel);
            if (i == 1){
                result.setSuccess(true);
            }else{
                result.setSuccess(false);
            }
            return result;
        }
    }

    @Override
    public SmsChannel queryEditChannelById(Integer channelId) {
        SmsChannel channelById = smsChannelDao.findChannelById(channelId);
        return channelById;
    }

    @Override
    public Result updateChannel(SmsChannel smsChannel) {
        Result result = new Result();
        int i = smsChannelDao.updateChannel(smsChannel);
        if (i == 1){
            result.setSuccess(true);
        }else{
            result.setSuccess(false);
        }
        return result;
    }

    @Override
    public Result deleteChannel(Integer channelId) {
        Result result = new Result();
        int i = smsChannelDao.deleteChannelById(channelId);
        if (i == 1){
            result.setSuccess(true);
        }else{
            result.setSuccess(false);
        }
        return result;
    }
}
