package com.gy.service.impl;

import com.gy.dao.SmsLoginDao;
import com.gy.dto.Result;
import com.gy.entity.SmsDetail;
import com.gy.entity.SysUser;
import com.gy.service.SmsLoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

/**
 * @ClassName SmsLoginServiceImpl
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/11/11 14:45
 **/
@Service
public class SmsLoginServiceImpl implements SmsLoginService {

    @Autowired
    private SmsLoginDao smsLogin;

    @Override
    public SysUser loginUser(String userName, String password) {
        SysUser user = smsLogin.findByUserName(userName,password);
        return user;
    }

    @Override
    public Result querySendNum() {
        Result result = new Result();
        List<SmsDetail> sendNum = smsLogin.findSendNum();
        result.setData(sendNum);
        return result;
    }

    @Override
    public Result queryCpSendNum(String cpName) {
        Result result = new Result();
        List<SmsDetail> sendNum = smsLogin.findCpSendNum(cpName);
        result.setData(sendNum);
        return result;
    }
}
