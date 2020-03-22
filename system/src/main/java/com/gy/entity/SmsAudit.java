package com.gy.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Date;

/**
 * @ClassName SmsAudit
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/6 15:52
 **/
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class SmsAudit {
    private Integer id;
    private String templateId;
    private String cp;
    private String channel;
    private Integer mobileCount;
    private String mobile;
    private String price;
    private String status;
    private String sendTime;
    private Date auditTime;
    private Date operateTime;

    private String variable;
    private String taskId;
}
