package com.gy.service;

import com.gy.dto.Result;
import com.gy.entity.SysUser;

/**
 * @ClassName SmsLoginService
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/11/11 14:42
 **/
public interface SmsLoginService {
    public SysUser loginUser(String userName, String password);

    public Result querySendNum();

    public Result queryCpSendNum(String cpName);
}
