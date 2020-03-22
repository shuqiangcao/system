package com.gy.service;

import com.gy.dto.Result;
import com.gy.entity.SmsSign;

import java.util.List;

/**
 * @ClassName SmsSignService
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/11/21 15:18
 **/
public interface SmsSignService {

    public Result findAllSign(Integer pageNum,Integer pageSize);

    public int querySign(SmsSign smsSign);

    public int insertSign(SmsSign smsSign);

    public SmsSign signBySignId(Integer signId);

    public Result updatesign(SmsSign smsSign);

    public Result deletesign(Integer signId);
}
