package com.gy.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Date;

/**
 * @ClassName SmsDetail
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/19 10:17
 **/
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class SmsDetail {
    private Integer id;
    private Integer infoId;
    private String msgId;
    private String cp;
    private String channel;
    private String price;
    private String type;
    private String templateId;
    private String templateName;
    private String sendContent;
    private Integer sendCount;
    private String sendMobile;
    private String timingTime;
    private String actualSendTime;
    private Date operateTime;
    private String dayTime;//映射折线图数据
    private Integer daySendNum;//映射折线图数据
}
