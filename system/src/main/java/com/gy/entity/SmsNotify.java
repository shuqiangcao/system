package com.gy.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Date;

/**
 * @ClassName SmsNotify
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/19 10:50
 **/
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class SmsNotify {
    private Integer id;
    @Excel(name = "批次号",orderNum = "0")
    private Integer infoId;
    private Integer detailId;
    private String msgId;
    @Excel(name = "手机号码",orderNum = "0")
    private String mobile;
    @Excel(name = "运营商",orderNum = "0")
    private String carrier;
    @Excel(name = "归属地",orderNum = "0")
    private String city;
    @Excel(name = "状态",orderNum = "0")
    private String result;
    private String isshow;
    @Excel(name = "渠道",orderNum = "0")
    private String cp;
    @Excel(name = "通道",orderNum = "0")
    private String channel;
    private String sendContent;
    private Date operateTime;

}
