package com.gy.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Date;

/**
 * @ClassName SmsInfo
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/19 10:23
 **/
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class SmsInfo {
    private Integer id;
    private String cp;
    private String templateId;
    private String templateName;
    private String channel;
    private String price;
    private String type;
    private String sendTime;
    private String sendContent;
    private Integer sendCount;
    private String sendMobile;
    private Integer blackListCount;
    private String blackListMobile;
    private Integer channelErrorCount;
    private String channelErrorMobile;
    private Integer countLimitCount;
    private String countLimitMobile;
    private Integer flowLimitCount;
    private String flowLimitMobile;
    private Integer maskWordCount;
    private String maskWordMobile;
    private Integer mobileErrorCount;
    private String mobileErrorMobile;
    private Integer moneyLimitCount;
    private String moneyLimitMobile;
    private Integer provinceLimitCount;
    private String provinceLimitMobile;
    private Integer templateCount;
    private String templateMobile;
    private Integer submitCount;
    private String submitMobile;
    private Date operateTime;
    private Date detailSendTime;
    private Date notifyTime;
    private Integer sendSuccessCount;
}
