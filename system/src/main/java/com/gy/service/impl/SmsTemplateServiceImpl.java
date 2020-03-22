package com.gy.service.impl;

import com.gy.dao.SmsTemplateDao;
import com.gy.dto.Result;
import com.gy.entity.SmsChannel;
import com.gy.entity.SmsCp;
import com.gy.entity.SmsTemplate;
import com.gy.service.SmsTemplateService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @ClassName SmsTemplateServiceImpl
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/11/27 11:31
 **/
@Service
@Slf4j
public class SmsTemplateServiceImpl implements SmsTemplateService {

    @Autowired
    SmsTemplateDao smsTemplateDao;

    @Override
    public Result findAllTemplate(Integer pageNum, Integer pageSize) {
        Result result = new Result();
        int templateSum = smsTemplateDao.findTemplate();
        int totalPage = 0;
        if (templateSum % pageSize == 0){
            totalPage = templateSum / pageSize;
        }else{
            totalPage = templateSum / pageSize +1;
        }
        List<SmsTemplate> allTemplate = smsTemplateDao.findAllTemplate(pageNum, pageSize);
        result.setPageSize(pageSize);
        result.setCountNum(templateSum);
        result.setPageNum(pageNum);
        result.setTotalPage(totalPage);
        result.setData(allTemplate);
        return result;
    }

    @Override
    public Result queryallchannel() {
        Result result = new Result();
        List<SmsChannel> channels = smsTemplateDao.findChannel();
        result.setData(channels);
        result.setSuccess(true);
        return result;
    }

    @Override
    public Result insertTemplate(SmsTemplate smsTemplate) {
        Result result = new Result();
        String channel = smsTemplate.getChannel();
        String[] channels = channel.split(",");
        String channelStr = "";
        for (int i = 0; i < channels.length ; i++) {
            channelStr += channels[i].substring(0,channels[i].indexOf("("))+"|";
        }
        log.info("通道:{}",channelStr);
        if (!"".equals(channelStr)){
            channelStr = channelStr.substring(0,channelStr.length()-1);
        }
        log.info("通道:{}",channelStr);
        smsTemplate.setChannel(channelStr);
        int i = smsTemplateDao.saveTemplate(smsTemplate);
        if (i == 1){
            result.setSuccess(true);
        }else{
            result.setSuccess(false);
        }
        return result;
    }

    @Override
    public Result queryTemplate(Integer templateId) {
        Result result = new Result();
        SmsTemplate templateById = smsTemplateDao.findTemplateById(templateId);
        if (templateById != null){
            result.setSuccess(true);
            result.setData(templateById);
        }else{
            result.setSuccess(false);
        }
        return result;
    }

    @Override
    public Result updateTemplate(SmsTemplate smsTemplate) {
        Result result = new Result();
        String channel = smsTemplate.getChannel();
        String[] channels = channel.split(",");
        String channelStr = "";
        for (int i = 0; i < channels.length ; i++) {
            channelStr += channels[i].substring(0,channels[i].indexOf("("))+"|";
        }
        log.info("编辑模板通道:{}",channelStr);
        if (!"".equals(channelStr)){
            channelStr = channelStr.substring(0,channelStr.length()-1);
        }
        log.info("编辑模板通道:{}",channelStr);
        smsTemplate.setChannel(channelStr);
        int i = smsTemplateDao.updateTemplate(smsTemplate);
        if (i == 1){
            result.setSuccess(true);
        }else{
            result.setSuccess(false);
        }
        return result;
    }

    @Override
    public Result deleteTemplate(Integer templateId) {
        Result result = new Result();
        int i = smsTemplateDao.deleteTemplate(templateId);
        if (i == 1){
            result.setSuccess(true);
        }else{
            result.setSuccess(false);
        }
        return result;
    }

    @Override
    public Result queryallCp() {
        Result result = new Result();
        List<SmsCp> cps = smsTemplateDao.findCp();
        result.setData(cps);
        result.setSuccess(true);
        return result;
    }
}
