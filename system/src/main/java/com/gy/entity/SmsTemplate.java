package com.gy.entity;

import lombok.Data;
import lombok.ToString;

import java.net.URLEncoder;
import java.util.Date;

/**
 * @ClassName SmsTemplateDao
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/11/27 11:14
 **/
@Data
@ToString
public class SmsTemplate {
    private Integer id;
    private String templateId;
    private String templateName;
    private String type;
    private String sendContent;
    private String describe;
    private String channel;
    private String cp;
    private String price;
    private String isAudit;
    private String isVariable;
    private String operator;
    private Date operateTime;
}
