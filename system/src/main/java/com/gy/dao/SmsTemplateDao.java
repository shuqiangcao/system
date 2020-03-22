package com.gy.dao;

import com.gy.entity.SmsChannel;
import com.gy.entity.SmsCp;
import com.gy.entity.SmsTemplate;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @ClassName SmsTemplateDao
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/11/27 11:30
 **/
public interface SmsTemplateDao {
    public int findTemplate();

    public List<SmsTemplate> findAllTemplate(@Param("pageNum") Integer pageNum, @Param("pageSize") Integer pageSize);

    public List<SmsChannel> findChannel();

    public int saveTemplate(SmsTemplate smsTemplate);

    public SmsTemplate findTemplateById(Integer templateId);

    public int updateTemplate(SmsTemplate smsTemplate);

    public int deleteTemplate(Integer templateId);

    public List<SmsCp> findCp();
}
