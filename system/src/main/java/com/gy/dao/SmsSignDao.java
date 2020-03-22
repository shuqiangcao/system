package com.gy.dao;

import com.gy.entity.SmsSign;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @ClassName SmsSignDao
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/11/21 15:08
 **/
public interface SmsSignDao {
    public List<SmsSign> querySignAll(@Param("pageNum") Integer pageNum, @Param("pageSize") Integer pageSize);

    public int signCount();

    public int fingSign(SmsSign smsSign);

    public int saveSign(SmsSign smsSign);

    public SmsSign findSignById(Integer signId);

    public int updatesign(SmsSign smsSign);

    public int deletesign(Integer signId);
}
