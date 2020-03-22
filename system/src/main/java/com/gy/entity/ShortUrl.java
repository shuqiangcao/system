package com.gy.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Date;

/**
 * @ClassName ShortUrl
 * @Description: TODO
 * @Author 曹树强
 * @Date 2020/1/15 9:30
 **/
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ShortUrl {
    private Integer id;
    private String mobile;
    private String longUrl;
    private String shortUrl;
    private String param;
    private String sinaUrl;
    private Date time;
}
