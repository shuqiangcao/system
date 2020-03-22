package com.gy.dao;

import com.gy.entity.SmsChannel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @ClassName SmsChannelDao
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/16 14:51
 **/
public interface SmsChannelDao {
    public int findchannelPageSum();

    public List<SmsChannel> findAllChannel(@Param("pageNum") Integer pageNum, @Param("pageSize") Integer pageSize);

    public SmsChannel findChannelByNameAndaccount(@Param("name") String name, @Param("account") String account);

    public int saveChannel(SmsChannel smsChannel);

    public SmsChannel findChannelById(Integer channelId);

    public int updateChannel(SmsChannel smsChannel);

    public int deleteChannelById(Integer channelId);
}
