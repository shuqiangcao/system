package com.gy.entity;

import lombok.Data;
import lombok.ToString;

import java.util.Date;

/**
 * @ClassName SmsSign
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/11/21 15:08
 **/
@Data
@ToString
public class SmsSign {
    private Integer id;
    private String signId;
    private String signName;
    private String cp;
    private String channel;
    private String operator;
    private Date operateTime;
}
