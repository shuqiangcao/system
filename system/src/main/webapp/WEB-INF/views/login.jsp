<%--
  Created by IntelliJ IDEA.
  User: 10396
  Date: 2019/11/11
  Time: 9:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="${basePath}/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${basePath}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${basePath}/css/login.css">
    <style>

    </style>
</head>
<body>
<div class="container">

    <form class="form-signin" role="form" action="/sms/submitlogin" method="post">
        <h2 class="form-signin-heading" style="text-align: center"><i class="glyphicon glyphicon-user"></i> 用户登录</h2>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="us" placeholder="账户" autofocus>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="password" class="form-control" id="pw" placeholder="密码" style="margin-top:10px;">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <div class="checkbox">
            <label>
                <input type="checkbox" value="remember-me"> 记住我
            </label>
            <br>
        </div>
        <a class="btn btn-lg btn-success btn-block" onclick="dologin()" > 登录</a>
    </form>
</div>
<script src="${basePath}/jquery/jquery-2.1.1.min.js"></script>
<script src="${basePath}/bootstrap/js/bootstrap.min.js"></script>
<script src="${basePath}/layer/layer.js"></script>
<script>
    function dologin() {
        var us = $("#us").val();
        var pw = $("#pw").val();
        if (us == ""){
            layer.msg("用户登录账户不能为空，请输入账户", {time:2000, icon:5, shift:6}, function(){});
            return;
        }
        if (pw == ""){
            layer.msg("用户登录密码不能为空，请输入密码", {time:2000, icon:5, shift:6}, function(){});
            return;
        }
        var loadingIndex = null;
        $.ajax({
            type:"POST",
            url:"${basePath}/sms/submitlogin",
            data:{"username":us,"password":pw},
            beforeSend:function () {
                loadingIndex =  layer.msg('登录中...', {icon: 16});
            },
            success:function(result){
                layer.close(loadingIndex);
                if (result.success){
                    window.location.href="${basePath}/sms/main";
                } else{
                    layer.msg("用户登录账户或密码错误，请重新输入", {time:2000, icon:5, shift:6}, function(){});
                }
            }
        });
    }
</script>
</body>
</html>
