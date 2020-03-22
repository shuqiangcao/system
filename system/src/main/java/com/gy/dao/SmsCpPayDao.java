package com.gy.dao;

import com.gy.entity.SmsCpConsume;
import com.gy.entity.SmsRechargeRecord;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @ClassName SmsCpPayDao
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/25 18:30
 **/
public interface SmsCpPayDao {
    public int findCppageSum(@Param("begintime") String begintime,@Param("endtime") String endtime,@Param("cp")String cp);

    public List<SmsRechargeRecord> findPayList(@Param("pageNum") Integer pageNum,@Param("pageSize") Integer pageSize,@Param("begintime")String begintime,@Param("endtime")String endtime,@Param("cp")String cp);

    public int findConsumepageSum(@Param("begintime") String begintime,@Param("endtime") String endtime,@Param("cp") String cp);

    public List<SmsCpConsume> findConsumeList(@Param("pageNum") Integer pageNum,@Param("pageSize") Integer pageSize,@Param("begintime") String begintime,@Param("endtime") String endtime,@Param("cp") String cp);

}
