package com.gy.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;


/**
 * @ClassName SmsSubmitCount
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/20 14:23
 **/
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class SmsSubmitCount {
    private String cp;
    private Integer num;
    private String dataTime;
}
