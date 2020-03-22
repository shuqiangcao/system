package com.gy.dao;

import com.gy.entity.SmsDetail;
import com.gy.entity.SysUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @ClassName SmsLoginDao
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/11/11 14:40
 **/
public interface SmsLoginDao {
    public SysUser findByUserName(@Param("username") String username, @Param("password") String password);

    public List<SmsDetail> findSendNum();

    public List<SmsDetail> findCpSendNum(String cpName);
}
