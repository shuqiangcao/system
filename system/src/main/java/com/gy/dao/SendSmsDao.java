package com.gy.dao;

import com.gy.entity.SmsAudit;
import com.gy.entity.SmsCp;
import com.gy.entity.SmsTemplate;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @ClassName SendSmsDao
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/6 15:59
 **/
public interface SendSmsDao {
    public List<SmsCp> findAllCp();

    public List<SmsTemplate> findSendTemplate();

    public SmsTemplate findTempById(Integer id);

    public int saveAudit(SmsAudit smsAudit);

    public List<SmsAudit> findAllAudit(@Param("pageNum") Integer pageNum, @Param("pageSize") Integer pageSize,@Param("begintime") String begintime, @Param("endtime") String endtime);

    public int findPageSum(@Param("begintime") String begintime, @Param("endtime") String endtime);

    public int findCpPageSum(@Param("cp") String cp, @Param("begintime") String begintime, @Param("endtime") String endtime,@Param("status") String status);

    public List<SmsAudit> findCpAllAudit(@Param("pageNum") Integer pageNum, @Param("pageSize") Integer pageSize, @Param("cp") String cp, @Param("begintime") String begintime, @Param("endtime") String endtime, @Param("status") String status);

    public int updateStatus(Integer id);

    public String findUserRoleId(Integer id);

    public List<SmsCp> findAllCpByname(String cpName);

    public List<SmsTemplate> findSendTemplateByname(String cpName);

    public SmsTemplate findIsAudit(String templateId);

    public SmsCp findCpByName(String cpName);

    public SmsAudit findAudit(Integer id);

    public int findRepeatSumit(@Param("cp") String cp,@Param("channel") String channel,@Param("submitdate") String nowDate,@Param("taskid") String taskId);

    public int insertSubmit(@Param("cp") String cp,@Param("channel") String channel,@Param("taskid") String taskId,@Param("submitdate") String nowDate);

    public String findAuditMobile(Integer id);

    public int deleteAuditById(Integer id);
}
