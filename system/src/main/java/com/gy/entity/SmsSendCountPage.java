package com.gy.entity;

import lombok.Data;
import lombok.ToString;

import java.util.Date;
import java.util.List;

/**
 * @ClassName SmsSendCountPage
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/19 18:42
 **/
@Data
@ToString
public class SmsSendCountPage {
    private Integer id;
    private String cp;
    private String channel;
    private Integer sendNum;
    private String way;
    private Integer submitNum;
    private Integer successNum;
    private Integer failNum;
    private Integer filterNum;
}
