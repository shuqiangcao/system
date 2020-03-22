package com.gy.service.impl;

import com.gy.dao.SmsSignDao;
import com.gy.dto.Result;
import com.gy.entity.SmsSign;
import com.gy.service.SmsSignService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @ClassName SmsSignServiceImpl
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/11/21 15:19
 **/
@Service
public class SmsSignServiceImpl implements SmsSignService {

    @Autowired
    private SmsSignDao smsSignDao;

    @Override
    public Result findAllSign(Integer pageNum, Integer pageSize) {
        Result result = new Result();
        int signSum = smsSignDao.signCount();
        int totalPage = 0;
        if (signSum % pageSize == 0){
            totalPage = signSum / pageSize;
        }else{
            totalPage = signSum / pageSize +1;
        }
        List<SmsSign> smsSigns = smsSignDao.querySignAll(pageNum, pageSize);
        result.setData(smsSigns);
        result.setTotalPage(totalPage);
        result.setPageNum(pageNum);
        result.setPageSize(pageSize);
        result.setCountNum(signSum);
        return result;
    }

    @Override
    public int querySign(SmsSign smsSign) {
        return smsSignDao.fingSign(smsSign);
    }

    @Override
    public int insertSign(SmsSign smsSign) {
        return smsSignDao.saveSign(smsSign);
    }

    @Override
    public SmsSign signBySignId(Integer signId) {
        return smsSignDao.findSignById(signId);
    }

    @Override
    public Result updatesign(SmsSign smsSign) {
        Result result = new Result();
        int updatesign = smsSignDao.updatesign(smsSign);
        if (updatesign == 1){
            result.setSuccess(true);
        }else {
            result.setSuccess(false);
        }
        return result;
    }

    @Override
    public Result deletesign(Integer signId) {
        Result result = new Result();
        int deletesign = smsSignDao.deletesign(signId);
        if (deletesign == 1){
            result.setSuccess(true);
        }else{
            result.setSuccess(false);
        }
        return result;
    }
}
