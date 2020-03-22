package com.gy.service;

import com.gy.dto.Result;
import com.gy.entity.SmsAudit;
import com.gy.entity.SmsCp;
import com.gy.entity.SmsTemplate;

import java.util.List;

/**
 * @ClassName SendSmsService
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/6 16:00
 **/
public interface SendSmsService {

    public List<SmsCp> queryCp();

    public List<SmsTemplate> queryTemplate();

    public Result queryTemplateById(Integer id);

    public Result insertAudit(SmsAudit smsAudit);

    public Result queryAllAudit(Integer pageNum,Integer pageSize);

    public Result queryCpAllAudit(Integer pageNum, Integer pageSize, String cp, String begintime, String endtime,String status);

    public Result doAudit(Integer id);

    public String queryUserAccess(Integer id);

    public List<SmsCp> queryCpByname(String cpName);

    public List<SmsTemplate> queryTemplateByname(String cpName);

    public Result queryauditMobile(Integer id);

    public Result deleteAudit(Integer id);
}
