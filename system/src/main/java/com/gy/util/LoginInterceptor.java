package com.gy.util;

import com.gy.entity.SysUser;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @ClassName LoginInterceptor
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/11/20 11:26
 **/
@Slf4j
public class LoginInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //判断是否是否已登录
        HttpSession session = request.getSession();
        SysUser loginuser = (SysUser)session.getAttribute("loginuser");
        if (loginuser == null){
            String basePath = (String)request.getAttribute("basePath");
            log.info("登录路径:{}",basePath);
            response.sendRedirect(basePath+"/sms/login");
            return false;
        }else{
            return true;
        }
    }
}
