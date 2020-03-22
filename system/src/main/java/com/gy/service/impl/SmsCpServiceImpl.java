package com.gy.service.impl;

import com.gy.dao.SmsCpDao;
import com.gy.dto.Result;
import com.gy.entity.SmsCp;
import com.gy.entity.SmsRechargeRecord;
import com.gy.entity.SysUser;
import com.gy.service.SmsCpService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.List;

/**
 * @ClassName SmsCpServiceImpl
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/13 11:09
 **/
@Service
@Slf4j
public class SmsCpServiceImpl implements SmsCpService {

    @Autowired
    private SmsCpDao smsCpDao;

    @Override
    public Result queryAllCp(Integer pageNum, Integer pageSize) {
        Result result = new Result();
        int pageSum = smsCpDao.findPageSum();
        int totalPage = 0;
        if (pageSum % pageSize == 0){
            totalPage = pageSum / pageSize;
        }else{
            totalPage = pageSum / pageSize +1;
        }
        List<SmsCp> allCp = smsCpDao.findAllCp(pageNum,pageSize);
        result.setPageSize(pageSize);
        result.setPageNum(pageNum);
        result.setCountNum(pageSum);
        result.setTotalPage(totalPage);
        result.setData(allCp);
        return result;
    }

    @Override
    public Result insertCp(SmsCp smsCp) {
        Result result = new Result();
        SmsCp cpByName = smsCpDao.findCpByName(smsCp.getName());
        if (cpByName != null){
            result.setSuccess(false);
            result.setRepeatCp(true);
            return  result;
        }else{
            int i = smsCpDao.saveCp(smsCp);
            if (i == 1){
                result.setSuccess(true);
            }else{
                result.setSuccess(false);
            }
            return result;
        }
    }

    @Override
    public Result queryCpById(Integer cpId) {
        Result result = new Result();
        SmsCp cpById = smsCpDao.findCpById(cpId);
        if (cpById != null){
            result.setSuccess(true);
            result.setData(cpById);
        }
        return result;
    }

    @Override
    public Result updateCpBalance(String name, String account, BigDecimal money, BigDecimal balance, HttpSession session) {
        Result result = new Result();
        BigDecimal moneySum = money.add(balance);
        int i = smsCpDao.updateBalance(name, account, moneySum);
        if (i == 1){
            SmsRechargeRecord record = new SmsRechargeRecord();
            record.setAccount(account);
            record.setName(name);
            record.setBalance(balance);
            record.setAfterBalance(moneySum);
            record.setRechargeMoney(money);
            SysUser loginuser = (SysUser)session.getAttribute("loginuser");
            record.setOperator(loginuser.getUserName());
            smsCpDao.insertRecord(record);
            result.setSuccess(true);
        }else{
            result.setSuccess(false);
        }
        return result;
    }

    @Override
    public SmsCp queryEditCpById(Integer cpId) {
        SmsCp editCpById = smsCpDao.findCpById(cpId);
        return editCpById;
    }

    @Override
    public Result updateCp(SmsCp smsCp) {
        Result result = new Result();
        int i = smsCpDao.updateCp(smsCp);
        if (i == 1){
            result.setSuccess(true);
        }else{
            result.setSuccess(false);
        }
        return result;
    }

    @Override
    public Result deleteCp(Integer cpId) {
        Result result = new Result();
        int i = smsCpDao.deleteCp(cpId);
        if (i == 1){
            result.setSuccess(true);
        }else {
            result.setSuccess(false);
        }
        return result;
    }


}
