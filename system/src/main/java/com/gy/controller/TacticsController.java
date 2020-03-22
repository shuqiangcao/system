package com.gy.controller;

import com.gy.dto.Result;
import com.gy.service.TacticsService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.net.URLDecoder;

/**
 * @ClassName StacticsController
 * @Description: TODO
 * @Author 曹树强
 * @Date 2020/1/11 14:28
 **/
@Controller
@RequestMapping("/policy")
@Slf4j
public class TacticsController {

    @Autowired
    TacticsService tacticsService;

    @RequestMapping("/sensitive")
    public String sensitive(){
        return "/tacticsmanagement/maskword";
    }

    @RequestMapping("checkmaskword")
    @ResponseBody
    public Result checkMaskword(@RequestParam String maskword) throws Exception{
        maskword = URLDecoder.decode(maskword,"UTF-8");
        Result result = tacticsService.queryMaskword(maskword);
        return result;
    }

    @RequestMapping("savemaskword")
    @ResponseBody
    public Result saveMaskword(@RequestParam String maskword) throws Exception{
        maskword = URLDecoder.decode(maskword,"UTF-8");
        log.info("敏感词:{}",maskword);
        Result result = tacticsService.insertMaskword(maskword);
        return result;
    }

}
