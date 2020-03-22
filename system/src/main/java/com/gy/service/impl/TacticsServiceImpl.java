package com.gy.service.impl;

import com.gy.dao.TacticsDao;
import com.gy.dto.Result;
import com.gy.service.TacticsService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Map;

/**
 * @ClassName StacticsServiceImpl
 * @Description: TODO
 * @Author 曹树强
 * @Date 2020/1/11 14:34
 **/
@Service
@Slf4j
public class TacticsServiceImpl implements TacticsService {

    @Autowired
    TacticsDao tacticsDao;

    @Override
    public Result queryMaskword(String maskword) {
        Result result = new Result();
        Map<String, Date> maskwordMap = tacticsDao.findMaskword(maskword);
        result.setData(maskwordMap);
        return result;
    }

    @Override
    public Result insertMaskword(String maskword) {
        Result result = new Result();
        int i = tacticsDao.saveword(maskword);
        if (i == 1){
            result.setSuccess(true);
        }else{
            result.setSuccess(false);
        }
        return result;
    }
}
