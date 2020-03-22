package com.gy.service;

import com.gy.dto.Result;
import com.gy.entity.SmsCp;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.List;

/**
 * @ClassName SmsCpService
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/13 11:09
 **/
public interface SmsCpService {
    public Result queryAllCp(Integer pageNum, Integer pageSize);

    public Result insertCp(SmsCp smsCp);

    public Result queryCpById(Integer cpId);

    public Result updateCpBalance(String name, String account, BigDecimal money, BigDecimal balance, HttpSession session);

    public SmsCp queryEditCpById(Integer cpId);

    public Result updateCp(SmsCp smsCp);

    public Result deleteCp(Integer cpId);
}
