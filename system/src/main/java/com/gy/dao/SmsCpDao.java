package com.gy.dao;

import com.gy.entity.SmsCp;
import com.gy.entity.SmsRechargeRecord;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;

/**
 * @ClassName SmsCpDao
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/13 11:07
 **/
public interface SmsCpDao {
    public List<SmsCp> findAllCp(@Param("pageNum") Integer pageNum,@Param("pageSize") Integer pageSize);

    public int findPageSum();

    public SmsCp findCpByName(String name);

    public int saveCp(SmsCp smsCp);

    public SmsCp findCpById(Integer cpId);

    public int updateBalance(@Param("name") String name, @Param("account") String account, @Param("money") BigDecimal money);

    public int insertRecord(SmsRechargeRecord record);

    public int updateCp(SmsCp smsCp);

    public int deleteCp(Integer cpId);
}
