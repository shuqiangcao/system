package com.gy.dao;

import com.gy.entity.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @ClassName SmsStatisticsDao
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/19 11:11
 **/
public interface SmsStatisticsDao {

    public int findPageSum(@Param("begintime") String begintime, @Param("endtime") String endtime,@Param("cp") String cpName);

    public List<SmsInfo> findAllrecord(@Param("pageNum") Integer pageNum, @Param("pageSize") Integer pageSize, @Param("begintime") String begintime, @Param("endtime") String endtime,@Param("cp") String cpName);

    //public List<SmsDetail> findAllrecord(@Param("pageNum") Integer pageNum,@Param("pageSize") Integer pageSize);

    public int findCpPageSum(@Param("cp") String cp, @Param("begintime") String begintime, @Param("endtime") String endtime);

    public List<SmsInfo> findCpAllRecord(@Param("pageNum") Integer pageNum, @Param("pageSize") Integer pageSize, @Param("cp") String cp, @Param("begintime") String begintime, @Param("endtime") String endtime);

    public int findSendCountPageSum(@Param("begintime") String begintime, @Param("endtime") String endtime,@Param("cp") String cpName);

    public List<SmsSendCountPage> findAllSendCount(@Param("pageNum") Integer pageNum, @Param("pageSize") Integer pageSize, @Param("begintime") String begintime, @Param("endtime") String endtime,@Param("cp") String cpName);

    public int findSubmitCountPageSum(@Param("begintime") String begintime, @Param("endtime") String endtime,@Param("cp") String cpName);

    public List<SmsSendCountPage> findSubmitCount(@Param("pageNum")Integer pageNum, @Param("pageSize") Integer pageSize, @Param("begintime") String begintime, @Param("endtime") String endtime,@Param("cp") String cpName);

    public int findCpSubmitCountPageSum(@Param("cp") String cp, @Param("channel") String channel, @Param("byway") String byway,@Param("begintime") String begintime, @Param("endtime") String endtime);

    public List<SmsSendCountPage> findCpSubmitCount(@Param("cp") String cp, @Param("channel") String channel, @Param("byway") String byway,@Param("pageNum") Integer pageNum, @Param("pageSize") Integer pageSize, @Param("begintime") String begintime, @Param("endtime") String endtime);

    public Date findSendTime(Integer infoId);

    public int findSendSuccessCount(Integer infoId);

    public Date findNotifyTime(Integer infoId);

    public List<SmsChannel> findChannel();

    public int findPageSumByWay(@Param("cp") String cp, @Param("channel") String channel, @Param("byway") String byway, @Param("begintime") String begintime, @Param("endtime") String endtime);

    public List<SmsSendCountPage> findSendSumByWay(@Param("cp") String cp, @Param("channel") String channel, @Param("byway") String byway, @Param("pageNum") Integer pageNum, @Param("pageSize") Integer pageSize, @Param("begintime") String begintime, @Param("endtime") String endtime);

    public int findSuccessCountPageSum(@Param("begintime") String begintime, @Param("endtime") String endtime,@Param("cp") String cpName);

    public List<SmsSendCountPage> findSuccessCount(@Param("pageNum") Integer pageNum, @Param("pageSize") Integer pageSize, @Param("begintime") String begintime, @Param("endtime") String endtime,@Param("cp") String cpName );

    public int findSuccPageSumByWay(@Param("cp") String cp, @Param("channel") String channel, @Param("byway") String byway,  @Param("begintime") String begintime, @Param("endtime") String endtime);

    public List<SmsSendCountPage> findSuccCount(@Param("cp") String cp, @Param("channel") String channel, @Param("byway") String byway, @Param("pageNum") Integer pageNum, @Param("pageSize") Integer pageSize, @Param("begintime") String begintime, @Param("endtime") String endtime);

    public int findFailCountPageSum(@Param("begintime") String begintime, @Param("endtime") String endtime, @Param("cp") String cpName);

    public List<SmsSendCountPage> findFailCount(@Param("pageNum") Integer pageNum, @Param("pageSize") Integer pageSize, @Param("begintime") String begintime, @Param("endtime") String endtime,@Param("cp") String cpName);

    public int findFailPageSumByWay(@Param("cp") String cp, @Param("channel") String channel, @Param("byway") String byway, @Param("begintime") String begintime,@Param("endtime") String endtime);

    public List<SmsSendCountPage> findFailCountByWay(@Param("cp") String cp, @Param("channel") String channel, @Param("byway") String byway, @Param("pageNum") Integer pageNum, @Param("pageSize") Integer pageSize, @Param("begintime") String begintime, @Param("endtime") String endtime);

    public int findStatusPageSum(@Param("mobile") String mobile,@Param("begintime") String begintime,@Param("endtime") String endtime,@Param("cpName") String cpName);

    public List<SmsMobileStatus> findMobileStatus(@Param("mobile") String mobile,@Param("pageNum") Integer pageNum,@Param("pageSize") Integer pageSize,@Param("begintime") String begintime,@Param("endtime") String endtime,@Param("cpName") String cpName);

    public String findMobileSendTime(@Param("infoId") Integer infoId,@Param("mobile") String mobile);

    public SmsNotify findMobileNotify(@Param("infoId") Integer infoId,@Param("mobile") String mobile);

    public int findInfoMsgPageSum(String infoId);

    public List<SmsNotify> findInfoMsg(@Param("infoId") String infoId, @Param("pageNum") Integer pageNum,@Param("pageSize") Integer pageSize);

    public int findtotalPageByStatus(@Param("infoId") String infoId, @Param("result") String resultstatus,@Param("mobile") String mobile);

    public List<SmsNotify> findInfoMsgByStatus(@Param("infoId") String infoId,@Param("result") String resultstatus,@Param("mobile") String mobile,@Param("pageNum") Integer pageNum,@Param("pageSize") Integer pageSize);

    public List<SmsSendCountPage> findinfoId(@Param("cp") String cp, @Param("channel") String channel, @Param("byway") String byway, @Param("begintime") String begintime, @Param("endtime") String endtime);

    public int findsuccNum(Integer id);

    public int findfailNum(Integer id);

    public List<SmsSendCountPage> findSmsSendinfoId(@Param("begintime") String begintime, @Param("endtime") String endtime, @Param("cpName") String cpName);

    public Map<String,Integer> findMobileFilter(String infoId);

    public List<SmsNotify> findExportMsg(String infoId);
}
