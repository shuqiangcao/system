package com.gy.service.impl;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.gy.dao.SendSmsDao;
import com.gy.dto.Result;
import com.gy.entity.SmsAudit;
import com.gy.entity.SmsCp;
import com.gy.entity.SmsTemplate;
import com.gy.service.SendSmsService;
import com.gy.util.HttpSendSms;
import com.gy.util.SmsMd5;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @ClassName SendSmsServiceImpl
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/6 16:00
 **/
@Service
@Slf4j
public class SendSmsServiceImpl implements SendSmsService {

    @Autowired
    SendSmsDao sendSmsDao;

    @Override
    public List<SmsCp> queryCp() {
        List<SmsCp> allCp = sendSmsDao.findAllCp();
        return allCp;
    }

    @Override
    public List<SmsTemplate> queryTemplate() {
        List<SmsTemplate> sendTemplate = sendSmsDao.findSendTemplate();
        return sendTemplate;
    }

    @Override
    public Result queryTemplateById(Integer id) {
        Result result = new Result();
        SmsTemplate templateById = sendSmsDao.findTempById(id);
        if (templateById != null){
            result.setSuccess(true);
            result.setData(templateById);
        }else{
            result.setSuccess(false);
        }
        return result;
    }

    @Override
    public Result insertAudit(SmsAudit smsAudit) {
        Result result = new Result();
        //是否需要审核  0:需要审核发送，1：直接发送，不需要审核
        SmsTemplate smsTemplate = sendSmsDao.findIsAudit(smsAudit.getTemplateId());
        if (smsTemplate != null){
            String isAudit = smsTemplate.getIsAudit();
            if ("0".equals(isAudit)){
                //入审核数据表
                String[] mobileStr = smsAudit.getMobile().split(",");
                Integer mobileCount = mobileStr.length;
                smsAudit.setMobileCount(mobileCount);
                smsAudit.setStatus("0"); //0：未审核
                String sendTime = "";
                if (!"".equals(smsAudit.getSendTime())){
                    sendTime = smsAudit.getSendTime()+":00";
                }
                smsAudit.setSendTime(sendTime);
                int i = sendSmsDao.saveAudit(smsAudit);
                if (i == 1){
                    result.setSuccess(true);
                }else{
                    result.setSuccess(false);
                }
            }else{
                try{
                    //判断同一渠道，同一通道此批次号码当天是否已成功提交过
//                    Set mobileSet = new HashSet();
//                    String[] paramMobile = smsAudit.getMobile().split(",");
//                    for (int i = 0;i < paramMobile.length; i++){
//                        log.info("传入号码:{}",paramMobile[i]);
//                        mobileSet.add(paramMobile[i]);
//                    }
//                    int paramMobileSize = mobileSet.size();
//                    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
//                    Date nowdate = new Date();
//                    String nowDate = format.format(nowdate);
//                    List<String> repeatSumit = sendSmsDao.findRepeatSumit(smsAudit.getCp(), smsAudit.getChannel(), nowDate);
//                    for (int i = 0;i < repeatSumit.size();i++){
//                        String[] repeatSumbitMobile = repeatSumit.get(i).split(",");
//                        log.info("数据库号码_1:{}",repeatSumbitMobile);
//                        for (int j = 0;j < repeatSumbitMobile.length;j++){
//                            log.info("数据库号码_2:{}",repeatSumbitMobile[j]);
//                            mobileSet.add(repeatSumbitMobile[j]);
//                        }
//                        if (paramMobileSize == mobileSet.size()){
//                            result.setRepeatSubmit(true);
//                            return result;
//                        }else{
//                            paramMobileSize = mobileSet.size();
//                        }
//                    }
                   SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                   Date nowdate = new Date();
                   String nowDate = format.format(nowdate);
                   int repeatSumit = sendSmsDao.findRepeatSumit(smsAudit.getCp(), smsAudit.getChannel(), nowDate,smsAudit.getTaskId());
                   if (repeatSumit > 0){
                       result.setRepeatSubmit(true);
                       return result;
                   }

                    //直接调用发送接口发送短信
                    String cpName = smsAudit.getCp();
                    SmsCp cpByName = sendSmsDao.findCpByName(cpName);
                    if (cpByName != null){
                        String sendTime = "";
                        if (!"".equals(smsAudit.getSendTime())){
                            sendTime = smsAudit.getSendTime()+":00";
                        }
                        String userId = cpByName.getName();
                        String password = cpByName.getPassWord();
                        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
                        Date date = new Date();
                        String timeStamp = dateFormat.format(date);
                        String sign = SmsMd5.tomd5(userId+password+timeStamp);
                        ObjectMapper objectMapper = new ObjectMapper();
                        ObjectNode node = objectMapper.createObjectNode();
                        node.put("userid",userId);
                        node.put("timestamp",timeStamp);
                        node.put("sign",sign);
                        node.put("mobile",smsAudit.getMobile());
                        node.put("serviceId",smsAudit.getTemplateId());
                        //node.put("content", URLEncoder.encode(smsTemplate.getTemplateName())+URLEncoder.encode(smsTemplate.getSendContent()));
                        node.put("content", smsAudit.getVariable());
                        node.put("sendTime",sendTime);
                        String param = node.toString();
                        String s = HttpSendSms.sendSms(param);
                        log.info("直接发送请求返回:{}",s);
                        JsonNode jsonNode = objectMapper.readTree(s);
                        String status = jsonNode.path("status").textValue();
                        if ("0".equals(status)){
                            result.setSuccess(true);
                            sendSmsDao.insertSubmit(smsAudit.getCp(),smsAudit.getChannel(),smsAudit.getTaskId(),nowDate);
                        }else{
                            result.setSuccess(false);
                        }
                        log.info("发送参数:{}",node.toString());
                    }else{
                        result.setSuccess(false);
                    }
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
        }else{
            result.setSuccess(false);
        }
        return result;
    }

    @Override
    public Result queryAllAudit(Integer pageNum,Integer pageSize) {
        Result result = new Result();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String begintime = dateFormat.format(date)+" 00:00:00";
        log.info("起始时间:{}",begintime);
        //获取后一天
//        Calendar calendar = Calendar.getInstance();
//        calendar.setTime(date);
//        int day = calendar.get(Calendar.DATE);
//        calendar.set(Calendar.DATE,day+1);
        String endtime = dateFormat.format(date)+" 23:59:59";
        log.info("起止时间:{}",endtime);
        int pageSum = sendSmsDao.findPageSum(begintime,endtime);
        int totalPage = 0;
        if (pageSum % pageSize == 0){
            totalPage = pageSum / pageSize;
        }else{
            totalPage = pageSum / pageSize +1;
        }
        List<SmsAudit> allAudit = sendSmsDao.findAllAudit(pageNum,pageSize,begintime,endtime);
        result.setPageNum(pageNum);
        result.setTotalPage(totalPage);
        result.setPageSize(pageSize);
        result.setCountNum(pageSum);
        result.setData(allAudit);
        return result;
    }

    @Override
    public Result queryCpAllAudit(Integer pageNum, Integer pageSize, String cp, String begintime, String endtime,String status) {
        Result result = new Result();
        begintime = begintime+" 00:00:00";
        endtime = endtime+" 23:59:59";
        int cpPageSum = sendSmsDao.findCpPageSum(cp, begintime, endtime,status);
        int totalPage = 0;
        if (cpPageSum % pageSize == 0){
            totalPage = cpPageSum / pageSize;
        }else{
            totalPage = cpPageSum / pageSize +1;
        }
        List<SmsAudit> cpAllAudit = sendSmsDao.findCpAllAudit(pageNum, pageSize, cp, begintime, endtime,status);
        result.setPageNum(pageNum);
        result.setTotalPage(totalPage);
        result.setPageSize(pageSize);
        result.setCountNum(cpPageSum);
        result.setData(cpAllAudit);
        return result;
    }

    @Override
    public Result doAudit(Integer id) {
        Result result = new Result();
        try{
            SmsAudit audit = sendSmsDao.findAudit(id);
            if (audit != null){

                //判断同一渠道，同一通道此批次号码当天是否已成功提交过
//                Set mobileSet = new HashSet();
//                String[] paramMobile = audit.getMobile().split(",");
//                for (int i = 0;i < paramMobile.length; i++){
//                    mobileSet.add(paramMobile[i]);
//                }
//                int paramMobileSize = mobileSet.size();
//                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
//                Date nowdate = new Date();
//                String nowDate = format.format(nowdate);
//                List<String> repeatSumit = sendSmsDao.findRepeatSumit(audit.getCp(), audit.getChannel(), nowDate);
//                for (int i = 0;i < repeatSumit.size();i++){
//                    String[] repeatSumbitMobile = repeatSumit.get(i).split(",");
//                    for (int j = 0;j < repeatSumbitMobile.length;j++){
//                        mobileSet.add(repeatSumbitMobile[j]);
//                    }
//                    if (paramMobileSize == mobileSet.size()){
//                        result.setRepeatSubmit(true);
//                        return result;
//                    }else{
//                        paramMobileSize = mobileSet.size();
//                    }
//                }

                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                Date nowdate = new Date();
                String nowDate = format.format(nowdate);
                int repeatSumit = sendSmsDao.findRepeatSumit(audit.getCp(), audit.getChannel(), nowDate,audit.getTaskId());
                if (repeatSumit > 0){
                    result.setRepeatSubmit(true);
                    return result;
                }

                //TODO 调用发送接口
                String cpName = audit.getCp();
                SmsCp cpByName = sendSmsDao.findCpByName(cpName);
                SmsTemplate tempById = sendSmsDao.findIsAudit(audit.getTemplateId());
                if (cpByName != null && tempById != null){
                    String userId = cpByName.getName();
                    String password = cpByName.getPassWord();
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
                    Date date = new Date();
                    String timeStamp = dateFormat.format(date);
                    String sign = SmsMd5.tomd5(userId+password+timeStamp);
                    ObjectMapper objectMapper = new ObjectMapper();
                    ObjectNode node = objectMapper.createObjectNode();
                    node.put("userid",userId);
                    node.put("timestamp",timeStamp);
                    node.put("sign",sign);
                    node.put("mobile",audit.getMobile());
                    node.put("serviceId",audit.getTemplateId());
                   // node.put("content", URLEncoder.encode(tempById.getTemplateName())+URLEncoder.encode(tempById.getSendContent()));
                    node.put("content", audit.getVariable());
                    node.put("sendTime",audit.getSendTime());
                    String param = node.toString();
                    String s = HttpSendSms.sendSms(param);
                    log.info("审核请求返回:{}",s);
                    JsonNode jsonNode = objectMapper.readTree(s);
                    String status = jsonNode.path("status").textValue();
                    if ("0".equals(status)){
                        int i = sendSmsDao.updateStatus(id);
                        if (i == 1){
                            result.setSuccess(true);
                            sendSmsDao.insertSubmit(audit.getCp(),audit.getChannel(),audit.getTaskId(),nowDate);
                        }else{
                            result.setSuccess(false);
                        }
                    }else{
                        result.setSuccess(false);
                    }
                    log.info("发送参数:{}"+node.toString());
                }else{
                    result.setSuccess(false);
                }
            }else{
                result.setSuccess(false);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

    @Override
    public String queryUserAccess(Integer id) {
        String userRoleId = sendSmsDao.findUserRoleId(id);
        return userRoleId;
    }

    @Override
    public List<SmsCp> queryCpByname(String cpName) {
        List<SmsCp> allCp = sendSmsDao.findAllCpByname(cpName);
        return allCp;
    }

    @Override
    public List<SmsTemplate> queryTemplateByname(String cpName) {
        List<SmsTemplate> sendTemplate = sendSmsDao.findSendTemplateByname(cpName);
        return sendTemplate;
    }

    @Override
    public Result queryauditMobile(Integer id) {
        Result result = new Result();
        String auditMobile = sendSmsDao.findAuditMobile(id);
        result.setData(auditMobile);
        return result;
    }

    @Override
    public Result deleteAudit(Integer id) {
        Result result = new Result();
        int i = sendSmsDao.deleteAuditById(id);
        if (i == 1){
            result.setSuccess(true);
        }else{
            result.setSuccess(false);
        }
        return result;
    }
}
