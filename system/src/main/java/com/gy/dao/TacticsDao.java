package com.gy.dao;

import java.util.Date;
import java.util.Map;

/**
 * @ClassName StacticsDao
 * @Description: TODO
 * @Author 曹树强
 * @Date 2020/1/11 14:35
 **/
public interface TacticsDao {
    public Map<String, Date> findMaskword(String maskword);

    public int saveword(String maskword);
}
