package com.gy.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Date;

/**
 * @ClassName SmsMobileStatus
 * @Description TODO
 * @Author caoshuqiang
 * @Date 2019/12/22 16:11
 */
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class SmsMobileStatus {
    private Integer id;
    private String sendContent;
    private Date operateTime;
    private String mobile;
    private String carrier;
    private String city;
    private String result;
    private String isshow;
    private String statusCp;
    private String statusChannel;
    private String sendTime;
    private Date notifyTime;
}
