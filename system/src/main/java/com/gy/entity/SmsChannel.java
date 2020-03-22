package com.gy.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Date;

/**
 * @ClassName SmsChannel
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/5 15:55
 **/
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class SmsChannel {
    private Integer id;
    private String account;
    private String alias;
    private String name;
    private String passWord;
    private String ip;
    private String port;
    private String url;
    private String keyWord;
    private String price;
    private Integer connections;
    private String srcId;
    private String accessMode;
    private Integer flowRate;
    private Integer weight;
    private String limitArea;
    private Date operateTime;
}
