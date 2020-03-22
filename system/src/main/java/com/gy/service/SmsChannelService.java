package com.gy.service;

import com.gy.dto.Result;
import com.gy.entity.SmsChannel;

/**
 * @ClassName SmsChannelService
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/16 14:52
 **/
public interface SmsChannelService {
    public Result queryAllChannel(Integer pageNum, Integer pageSize);

    public Result insertChannel(SmsChannel smsChannel);

    public SmsChannel queryEditChannelById(Integer channelId);

    public Result updateChannel(SmsChannel smsChannel);

    public Result deleteChannel(Integer channelId);
}
