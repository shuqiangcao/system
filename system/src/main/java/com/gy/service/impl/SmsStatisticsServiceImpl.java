package com.gy.service.impl;

import com.gy.dao.SmsStatisticsDao;
import com.gy.dto.FailDTO;
import com.gy.dto.Result;
import com.gy.dto.SuccessDTO;
import com.gy.entity.*;
import com.gy.service.SmsStatisticsService;
import com.gy.util.ExcelUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.HttpResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @ClassName SmsStatisticsServiceImpl
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/19 11:12
 **/
@Service
@Slf4j
public class SmsStatisticsServiceImpl implements SmsStatisticsService {

    @Autowired
    private SmsStatisticsDao smsStatisticsDao;

    @Override
    public Result queryAllrecord(Integer pageNum, Integer pageSize,String cpName) {
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

        int pageSum = smsStatisticsDao.findPageSum(begintime, endtime,cpName);
        List<SmsInfo> smsInfos = smsStatisticsDao.findAllrecord(pageNum, pageSize, begintime, endtime,cpName);
        int totalPage = 0;
        if (pageSum % pageSize == 0){
            totalPage = pageSum / pageSize;
        }else{
            totalPage = pageSum / pageSize +1;
        }
        for (SmsInfo smsInfo: smsInfos) {
            Integer infoId = smsInfo.getId();
            Date sendTime = smsStatisticsDao.findSendTime(infoId);
            int sendSuccessCount = smsStatisticsDao.findSendSuccessCount(infoId);
            Date notifyTime = smsStatisticsDao.findNotifyTime(infoId);
            smsInfo.setDetailSendTime(sendTime);
            smsInfo.setNotifyTime(notifyTime);
            smsInfo.setSendSuccessCount(sendSuccessCount);
        }
        //List<SmsDetail> allrecord = smsStatisticsDao.findAllrecord(pageNum,pageSize);
        result.setPageNum(pageNum);
        result.setTotalPage(totalPage);
        result.setPageSize(pageSize);
        result.setCountNum(pageSum);
        result.setData(smsInfos);
        return result;
    }

    @Override
    public Result queryRecord(Integer pageNum, Integer pageSize, String cp, String begintime, String endtime) {
        begintime = begintime+" 00:00:00";
        endtime = endtime+ " 23:59:59";
        Result result = new Result();
        int cpPageSum = smsStatisticsDao.findCpPageSum(cp, begintime, endtime);
        int totalPage = 0;
        if (cpPageSum % pageSize == 0){
            totalPage = cpPageSum / pageSize;
        }else{
            totalPage = cpPageSum / pageSize +1;
        }
        List<SmsInfo> cpAllRecord = smsStatisticsDao.findCpAllRecord(pageNum, pageSize, cp, begintime, endtime);
        for (SmsInfo smsInfo: cpAllRecord) {
            Integer infoId = smsInfo.getId();
            Date sendTime = smsStatisticsDao.findSendTime(infoId);
            int sendSuccessCount = smsStatisticsDao.findSendSuccessCount(infoId);
            Date notifyTime = smsStatisticsDao.findNotifyTime(infoId);
            smsInfo.setDetailSendTime(sendTime);
            smsInfo.setNotifyTime(notifyTime);
            smsInfo.setSendSuccessCount(sendSuccessCount);
        }
        result.setPageNum(pageNum);
        result.setTotalPage(totalPage);
        result.setPageSize(pageSize);
        result.setCountNum(cpPageSum);
        result.setData(cpAllRecord);
        return result;
    }

    @Override
    public Result querySendCount(Integer pageNum, Integer pageSize, String begintime, String endtime,String cpName) {
        if ("".equals(begintime) && "".equals(endtime)){
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();
            begintime = dateFormat.format(date)+" 00:00:00";
            log.info("起始时间:{}",begintime);
            //获取后一天
//        Calendar calendar = Calendar.getInstance();
//        calendar.setTime(date);
//        int day = calendar.get(Calendar.DATE);
//        calendar.set(Calendar.DATE,day+1);
            endtime = dateFormat.format(date)+" 23:59:59";
            log.info("起止时间:{}",endtime);
        }else{
            begintime = begintime+" 00:00:00";
            endtime = endtime+ " 23:59:59";
        }
        Result result = new Result();
        int sendCountPageSum = smsStatisticsDao.findSendCountPageSum(begintime, endtime,cpName);
        int totalPage = 0;
        if (sendCountPageSum % pageSize == 0){
            totalPage = sendCountPageSum / pageSize;
        }else{
            totalPage = sendCountPageSum / pageSize +1;
        }
        List<SmsSendCountPage> AllSendCount = smsStatisticsDao.findAllSendCount(pageNum, pageSize,begintime, endtime,cpName);

        result.setSuccess(true);
        result.setPageNum(pageNum);
        result.setTotalPage(totalPage);
        result.setCountNum(sendCountPageSum);
        result.setPageSize(pageSize);
        result.setData(AllSendCount);
        log.info("返回数据:{}",result.toString());
        return result;
    }

    @Override
    public Result querySendCountByWay(String cp, String channel, String byway, Integer pageNum, Integer pageSize, String begintime, String endtime) {
        begintime = begintime+" 00:00:00";
        endtime = endtime+ " 23:59:59";
        Result result = new Result();
        int sumByWay = smsStatisticsDao.findPageSumByWay(cp, channel, byway, begintime, endtime);
        int totalPage = 0;
        if (sumByWay % pageSize == 0){
            totalPage = sumByWay / pageSize;
        }else{
            totalPage = sumByWay / pageSize +1;
        }
        List<SmsSendCountPage> sendSumByWay = smsStatisticsDao.findSendSumByWay(cp, channel, byway, pageNum, pageSize, begintime, endtime);
        result.setSuccess(true);
        result.setPageNum(pageNum);
        result.setTotalPage(totalPage);
        result.setCountNum(sumByWay);
        result.setPageSize(pageSize);
        result.setData(sendSumByWay);
        return result;
    }

    @Override
    public Result querySmsSubmit(Integer pageNum, Integer pageSize, String begintime, String endtime,String cpName) {
        if ("".equals(begintime) && "".equals(endtime)){
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();
            begintime = dateFormat.format(date)+" 00:00:00";
            log.info("起始时间:{}",begintime);
            //获取后一天
//        Calendar calendar = Calendar.getInstance();
//        calendar.setTime(date);
//        int day = calendar.get(Calendar.DATE);
//        calendar.set(Calendar.DATE,day+1);
            endtime = dateFormat.format(date)+" 23:59:59";
            log.info("起止时间:{}",endtime);
        }else{
            begintime = begintime+" 00:00:00";
            endtime = endtime+ " 23:59:59";
        }
        Result result = new Result();
        int sendCountPageSum = smsStatisticsDao.findSubmitCountPageSum(begintime, endtime,cpName);
        int totalPage = 0;
        if (sendCountPageSum % pageSize == 0){
            totalPage = sendCountPageSum / pageSize;
        }else{
            totalPage = sendCountPageSum / pageSize +1;
        }
        List<SmsSendCountPage> AllSubmitCount = smsStatisticsDao.findSubmitCount(pageNum, pageSize, begintime, endtime,cpName);
        result.setData(AllSubmitCount);
        result.setTotalPage(totalPage);
        result.setPageNum(pageNum);
        result.setPageSize(pageSize);
        result.setCountNum(sendCountPageSum);
        return result;
    }

    @Override
    public Result queryCpSmsSubmit(String cp, String channel, String byway,Integer pageNum, Integer pageSize, String begintime, String endtime) {
        begintime = begintime+" 00:00:00";
        endtime = endtime+ " 23:59:59";
        Result result = new Result();
        int sendCountPageSum = smsStatisticsDao.findCpSubmitCountPageSum(cp, channel, byway, begintime, endtime);
        int totalPage = 0;
        if (sendCountPageSum % pageSize == 0){
            totalPage = sendCountPageSum / pageSize;
        }else{
            totalPage = sendCountPageSum / pageSize +1;
        }
        List<SmsSendCountPage> AllCpSubmitCount = smsStatisticsDao.findCpSubmitCount(cp, channel, byway, pageNum, pageSize, begintime, endtime);
        result.setData(AllCpSubmitCount);
        result.setTotalPage(totalPage);
        result.setPageNum(pageNum);
        result.setPageSize(pageSize);
        result.setCountNum(sendCountPageSum);
        return result;
    }

    @Override
    public List<SmsChannel> queryChannel() {
        List<SmsChannel> smsChannelList = smsStatisticsDao.findChannel();
        return smsChannelList;
    }

    @Override
    public Result querySmsSuccess(Integer pageNum, Integer pageSize, String begintime, String endtime,String cpName) {
        if ("".equals(begintime) && "".equals(endtime)){
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();
            begintime = dateFormat.format(date)+" 00:00:00";
            log.info("起始时间:{}",begintime);
            //获取后一天
//        Calendar calendar = Calendar.getInstance();
//        calendar.setTime(date);
//        int day = calendar.get(Calendar.DATE);
//        calendar.set(Calendar.DATE,day+1);
            endtime = dateFormat.format(date)+" 23:59:59";
            log.info("起止时间:{}",endtime);
        }else{
            begintime = begintime+" 00:00:00";
            endtime = endtime+ " 23:59:59";
        }
        Result result = new Result();
        int sendCountPageSum = smsStatisticsDao.findSendCountPageSum(begintime, endtime,cpName);
        int totalPage = 0;
        if (sendCountPageSum % pageSize == 0){
            totalPage = sendCountPageSum / pageSize;
        }else{
            totalPage = sendCountPageSum / pageSize +1;
        }
        List<SmsSendCountPage> allSubmitCount = smsStatisticsDao.findSmsSendinfoId(begintime, endtime,cpName);
        int succNum = 0;
        String dateStr = "";
        SuccessDTO successDTO = new SuccessDTO();
        for (SmsSendCountPage smsSendCountPage: allSubmitCount) {
            successDTO.setDateStr(smsSendCountPage.getWay());
            int findsuccNum = smsStatisticsDao.findsuccNum(smsSendCountPage.getId());
            succNum = succNum + findsuccNum;
        }
        successDTO.setSuccNum(succNum);
        List<SuccessDTO> resultList = new ArrayList<SuccessDTO>();
        resultList.add(successDTO);
        result.setData(resultList);
        result.setTotalPage(totalPage);
        result.setPageNum(pageNum);
        result.setPageSize(pageSize);
        result.setCountNum(sendCountPageSum);
        return result;
    }

    @Override
    public Result querySmsSuccByWay(String cp, String channel, String byway, Integer pageNum, Integer pageSize, String begintime, String endtime) {
        begintime = begintime+" 00:00:00";
        endtime = endtime+ " 23:59:59";
        Result result = new Result();
        int sendCountPageSum = smsStatisticsDao.findPageSumByWay(cp, channel, byway, begintime, endtime);
        int totalPage = 0;
        if (sendCountPageSum % pageSize == 0){
            totalPage = sendCountPageSum / pageSize;
        }else{
            totalPage = sendCountPageSum / pageSize +1;
        }
        //List<SmsSendCountPage> AllCpSubmitCount = smsStatisticsDao.findSuccCount(cp, channel, byway, pageNum, pageSize, begintime, endtime);
        List<SmsSendCountPage> sendSumByWay = smsStatisticsDao.findSendSumByWay(cp, channel, byway, pageNum, pageSize, begintime, endtime);
        List<SmsSendCountPage> smsSendCount = smsStatisticsDao.findinfoId(cp, channel, byway, begintime, endtime);
        int succNum = 0;
        for (SmsSendCountPage smsSendCountPage : sendSumByWay){

            for (SmsSendCountPage smsSendCountPage2 : smsSendCount){
                if (smsSendCountPage.getWay().equals(smsSendCountPage2.getWay())){
                    int num = smsStatisticsDao.findsuccNum(smsSendCountPage2.getId());
                    succNum = succNum+num;
                }
                smsSendCountPage.setSuccessNum(succNum);
            }
            succNum = 0;
        }

        result.setData(sendSumByWay);
        result.setTotalPage(totalPage);
        result.setPageNum(pageNum);
        result.setCountNum(sendCountPageSum);
        result.setPageSize(pageSize);
        return result;
    }

    @Override
    public Result querySmsFail(Integer pageNum, Integer pageSize, String begintime, String endtime,String cpName) {
        if ("".equals(begintime) && "".equals(endtime)){
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();
            begintime = dateFormat.format(date)+" 00:00:00";
            log.info("起始时间:{}",begintime);
            //获取后一天
//        Calendar calendar = Calendar.getInstance();
//        calendar.setTime(date);
//        int day = calendar.get(Calendar.DATE);
//        calendar.set(Calendar.DATE,day+1);
            endtime = dateFormat.format(date)+" 23:59:59";
            log.info("起止时间:{}",endtime);
        }else{
            begintime = begintime+" 00:00:00";
            endtime = endtime+ " 23:59:59";
        }
        Result result = new Result();
        int sendCountPageSum = smsStatisticsDao.findSendCountPageSum(begintime, endtime,cpName);
        int totalPage = 0;
        if (sendCountPageSum % pageSize == 0){
            totalPage = sendCountPageSum / pageSize;
        }else{
            totalPage = sendCountPageSum / pageSize +1;
        }
        List<SmsSendCountPage> allSubmitCount = smsStatisticsDao.findSmsSendinfoId(begintime, endtime,cpName);
        int failNum = 0;
        String dateStr = "";
        FailDTO failDTO = new FailDTO();
        for (SmsSendCountPage smsSendCountPage: allSubmitCount) {
            failDTO.setDateStr(smsSendCountPage.getWay());
            int findsuccNum = smsStatisticsDao.findfailNum(smsSendCountPage.getId());
            failNum = failNum + findsuccNum;
        }
        failDTO.setFailNum(failNum);
        List<FailDTO> resultList = new ArrayList<FailDTO>();
        resultList.add(failDTO);
        result.setData(resultList);
        result.setTotalPage(totalPage);
        result.setPageNum(pageNum);
        result.setPageSize(pageSize);
        result.setCountNum(sendCountPageSum);
        return result;
    }

    @Override
    public Result querySmsFailByWay(String cp, String channel, String byway, Integer pageNum, Integer pageSize, String begintime, String endtime) {
        begintime = begintime+" 00:00:00";
        endtime = endtime+ " 23:59:59";
        Result result = new Result();
        int sendCountPageSum = smsStatisticsDao.findPageSumByWay(cp, channel, byway, begintime, endtime);
        int totalPage = 0;
        if (sendCountPageSum % pageSize == 0){
            totalPage = sendCountPageSum / pageSize;
        }else{
            totalPage = sendCountPageSum / pageSize +1;
        }
        //List<SmsSendCountPage> AllCpSubmitCount = smsStatisticsDao.findFailCountByWay(cp, channel, byway, pageNum, pageSize, begintime, endtime);
        List<SmsSendCountPage> sendSumByWay = smsStatisticsDao.findSendSumByWay(cp, channel, byway, pageNum, pageSize, begintime, endtime);
        List<SmsSendCountPage> smsSendCount = smsStatisticsDao.findinfoId(cp, channel, byway, begintime, endtime);
        int failNum = 0;
        for (SmsSendCountPage smsSendCountPage : sendSumByWay){

            for (SmsSendCountPage smsSendCountPage2 : smsSendCount){
                if (smsSendCountPage.getWay().equals(smsSendCountPage2.getWay())){
                    int num = smsStatisticsDao.findfailNum(smsSendCountPage2.getId());
                    failNum = failNum+num;
                }
                smsSendCountPage.setFailNum(failNum);
            }
            failNum = 0;
        }

        result.setData(sendSumByWay);
        result.setTotalPage(totalPage);
        result.setPageNum(pageNum);
        result.setCountNum(sendCountPageSum);
        result.setPageSize(pageSize);
        return result;
    }

    @Override
    public Result querySmsstatus(String mobile, Integer pageNum, Integer pageSize, String begintime, String endtime,String cpName) {
        Result result = new Result();
        begintime = begintime+" 00:00:00";
        endtime = endtime+" 23:59:59";
        int SendCountPageSum = smsStatisticsDao.findStatusPageSum(mobile, begintime, endtime,cpName);
        int totalPage = 0;
        if (SendCountPageSum % pageSize == 0){
            totalPage = SendCountPageSum / pageSize;
        }else{
            totalPage = SendCountPageSum / pageSize +1;
        }
        List<SmsMobileStatus> AllMobileStatus = smsStatisticsDao.findMobileStatus(mobile, pageNum, pageSize, begintime, endtime,cpName);
        for (SmsMobileStatus smsMobileStatus : AllMobileStatus){
            Integer infoId = smsMobileStatus.getId();
            String mobileSendTime = smsStatisticsDao.findMobileSendTime(infoId,mobile);
            SmsNotify mobileNotify = smsStatisticsDao.findMobileNotify(infoId,mobile);
            smsMobileStatus.setMobile(mobile);
            if (mobileSendTime != null){
                smsMobileStatus.setSendTime(mobileSendTime);
            }
            if (mobileNotify != null){
                smsMobileStatus.setStatusCp(mobileNotify.getCp());
                smsMobileStatus.setStatusChannel(mobileNotify.getChannel());
                smsMobileStatus.setCarrier(mobileNotify.getCarrier());
                smsMobileStatus.setCity(mobileNotify.getCity());
                smsMobileStatus.setResult(mobileNotify.getResult());
                smsMobileStatus.setIsshow(mobileNotify.getIsshow());
                smsMobileStatus.setNotifyTime(mobileNotify.getOperateTime());
            }
        }
        result.setData(AllMobileStatus);
        result.setTotalPage(totalPage);
        result.setPageNum(pageNum);
        result.setPageSize(pageSize);
        result.setCountNum(SendCountPageSum);
        return result;
    }

    @Override
    public Result querySmsInfoMsg(String infoId, Integer pageNum, Integer pageSize) {
        Result result = new Result();
        int infoMsgPageSum = smsStatisticsDao.findInfoMsgPageSum(infoId);
        int totalPage = 0;
        if (infoMsgPageSum % pageSize == 0){
            totalPage = infoMsgPageSum / pageSize;
        }else{
            totalPage = infoMsgPageSum / pageSize +1;
        }
        List<SmsNotify> infoMsg = smsStatisticsDao.findInfoMsg(infoId, pageNum, pageSize);
        result.setData(infoMsg);
        result.setPageNum(pageNum);
        result.setPageSize(pageSize);
        result.setCountNum(infoMsgPageSum);
        result.setTotalPage(totalPage);
        return result;
    }

    @Override
    public Result checkSmsInfoMsg(String infoId, String resultstatus, String mobile, Integer pageNum, Integer pageSize) {
        Result result = new Result();
        int infoMsgPageSum = smsStatisticsDao.findtotalPageByStatus(infoId,resultstatus,mobile);
        int totalPage = 0;
        if (infoMsgPageSum % pageSize == 0){
            totalPage = infoMsgPageSum / pageSize;
        }else{
            totalPage = infoMsgPageSum / pageSize +1;
        }
        List<SmsNotify> infoMsg = smsStatisticsDao.findInfoMsgByStatus(infoId,resultstatus,mobile, pageNum, pageSize);
        result.setData(infoMsg);
        result.setPageNum(pageNum);
        result.setPageSize(pageSize);
        result.setCountNum(infoMsgPageSum);
        result.setTotalPage(totalPage);
        return result;
    }

    @Override
    public Result querySmsSendCount(Integer pageNum, Integer pageSize, String begintime, String endtime, String cpName) {
        if ("".equals(begintime) && "".equals(endtime)){
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();
            begintime = dateFormat.format(date)+" 00:00:00";
            log.info("起始时间:{}",begintime);
            //获取后一天
//        Calendar calendar = Calendar.getInstance();
//        calendar.setTime(date);
//        int day = calendar.get(Calendar.DATE);
//        calendar.set(Calendar.DATE,day+1);
            endtime = dateFormat.format(date)+" 23:59:59";
            log.info("起止时间:{}",endtime);
        }else{
            begintime = begintime+" 00:00:00";
            endtime = endtime+ " 23:59:59";
        }
        Result result = new Result();
        int sendCountPageSum = smsStatisticsDao.findSendCountPageSum(begintime, endtime,cpName);
        int totalPage = 0;
        if (sendCountPageSum % pageSize == 0){
            totalPage = sendCountPageSum / pageSize;
        }else{
            totalPage = sendCountPageSum / pageSize +1;
        }
        List<SmsSendCountPage> allSendCount = smsStatisticsDao.findAllSendCount(pageNum, pageSize,begintime, endtime,cpName);
        List<SmsSendCountPage> allSubmitCount = smsStatisticsDao.findSubmitCount(pageNum, pageSize, begintime, endtime,cpName);
        //List<SmsSendCountPage> allSuccessCount = smsStatisticsDao.findSuccessCount(pageNum, pageSize, begintime, endtime,cpName);
        List<SmsSendCountPage> allinfoId = smsStatisticsDao.findSmsSendinfoId(begintime, endtime,cpName);
        //List<SmsSendCountPage> allfailCount = smsStatisticsDao.findFailCount(pageNum, pageSize, begintime, endtime,cpName);
        int succNum = 0;
        int fialNum = 0;
        for (SmsSendCountPage smsSendCountPage : allSendCount){
            for (SmsSendCountPage smsSendCountPage1 : allSubmitCount){
                if (smsSendCountPage.getWay().equals(smsSendCountPage1.getWay())){
                    smsSendCountPage.setSubmitNum(smsSendCountPage1.getSendNum());
                }
            }
            for (SmsSendCountPage smsSendCountPage2 : allinfoId){

                //smsSendCountPage.setSuccessNum(smsSendCountPage2.getSendNum());
                int num = smsStatisticsDao.findsuccNum(smsSendCountPage2.getId());
                int num_1 = smsStatisticsDao.findfailNum(smsSendCountPage2.getId());
                succNum = succNum+num;
                fialNum = fialNum+num_1;
                smsSendCountPage.setSuccessNum(succNum);
                smsSendCountPage.setFailNum(fialNum);
            }
            succNum = 0;
            fialNum = 0;
//            for (SmsSendCountPage smsSendCountPage3 : allfailCount){
//                if (smsSendCountPage.getWay().equals(smsSendCountPage3.getWay())){
//                    smsSendCountPage.setFailNum(smsSendCountPage3.getSendNum());
//                }
//            }
        }
        result.setData(allSendCount);
        result.setPageNum(pageNum);
        result.setPageSize(pageSize);
        result.setCountNum(sendCountPageSum);
        result.setTotalPage(totalPage);
        return result;
    }

    @Override
    public Result querySmsSendCountByWay(String cp, String channel, String byway, Integer pageNum, Integer pageSize, String begintime, String endtime) {
        begintime = begintime+" 00:00:00";
        endtime = endtime+ " 23:59:59";
        Result result = new Result();
        int sumByWay = smsStatisticsDao.findPageSumByWay(cp, channel, byway, begintime, endtime);
        int totalPage = 0;
        if (sumByWay % pageSize == 0){
            totalPage = sumByWay / pageSize;
        }else{
            totalPage = sumByWay / pageSize +1;
        }
        List<SmsSendCountPage> sendSumByWay = smsStatisticsDao.findSendSumByWay(cp, channel, byway, pageNum, pageSize, begintime, endtime);
        List<SmsSendCountPage> allCpSubmitCount = smsStatisticsDao.findCpSubmitCount(cp, channel, byway, pageNum, pageSize, begintime, endtime);
        //List<SmsSendCountPage> allCpSuccessCount = smsStatisticsDao.findSuccCount(cp, channel, byway, pageNum, pageSize, begintime, endtime);
        List<SmsSendCountPage> allinfoId = smsStatisticsDao.findinfoId(cp, channel, byway,begintime, endtime);
        //List<SmsSendCountPage> allCpfailCount = smsStatisticsDao.findFailCountByWay(cp, channel, byway, pageNum, pageSize, begintime, endtime);
        int succNum = 0;
        int fialNum = 0;
        for (SmsSendCountPage smsSendCountPage : sendSumByWay){
            for (SmsSendCountPage smsSendCountPage1 : allCpSubmitCount){
                if (smsSendCountPage.getWay().equals(smsSendCountPage1.getWay())){
                    smsSendCountPage.setSubmitNum(smsSendCountPage1.getSendNum());
                }
            }
            for (SmsSendCountPage smsSendCountPage2 : allinfoId){
                if (smsSendCountPage.getWay().equals(smsSendCountPage2.getWay())){
                    int num = smsStatisticsDao.findsuccNum(smsSendCountPage2.getId());
                    int num_1 = smsStatisticsDao.findfailNum(smsSendCountPage2.getId());
                    succNum = succNum+num;
                    fialNum = fialNum+num_1;
                }
                smsSendCountPage.setSuccessNum(succNum);
                smsSendCountPage.setFailNum(fialNum);
            }
            succNum = 0;
            fialNum = 0;

//            for (SmsSendCountPage smsSendCountPage3 : allCpfailCount){
//                if (smsSendCountPage.getWay().equals(smsSendCountPage3.getWay())){
//                    smsSendCountPage.setFailNum(smsSendCountPage3.getSendNum());
//                }
//            }
        }

        result.setData(sendSumByWay);
        result.setPageNum(pageNum);
        result.setPageSize(pageSize);
        result.setCountNum(sumByWay);
        result.setTotalPage(totalPage);
        return result;
    }

    @Override
    public Result queryMobileFilter(String infoId) {
        Result result = new Result();
        Map<String, Integer> mobileFilter = smsStatisticsDao.findMobileFilter(infoId);
        result.setData(mobileFilter);
        return result;
    }

    @Override
    public List<SmsNotify> exportMobileMsg(String infoId) {
        List<SmsNotify> exportMsg = smsStatisticsDao.findExportMsg(infoId);
        return exportMsg;
    }

}
