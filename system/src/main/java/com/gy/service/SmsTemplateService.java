package com.gy.service;

import com.gy.dto.Result;
import com.gy.entity.SmsTemplate;

import java.util.List;

/**
 * @ClassName SmsTemplateService
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/11/27 11:31
 **/
public interface SmsTemplateService {

    public Result findAllTemplate(Integer pageNum, Integer pageSize);

    public Result queryallchannel();

    public Result insertTemplate(SmsTemplate smsTemplate);

    public Result queryTemplate(Integer templateId);

    public Result updateTemplate(SmsTemplate smsTemplate);

    public Result deleteTemplate(Integer templateId);

    public Result queryallCp();
}
