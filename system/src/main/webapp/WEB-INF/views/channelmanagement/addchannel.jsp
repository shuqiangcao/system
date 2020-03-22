<%--
  Created by IntelliJ IDEA.
  User: 10396
  Date: 2020/1/7
  Time: 14:17
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Dashboard">

    <!-- Bootstrap core CSS -->
    <link href="${basePath}/assets/css/bootstrap.css" rel="stylesheet">
    <!--external css-->
    <link href="${basePath}/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <!-- Custom styles for this template -->
    <link href="${basePath}/assets/css/style.css" rel="stylesheet">
    <link href="${basePath}/assets/css/style-responsive.css" rel="stylesheet">
    <style>
        table th{text-align: center;vertical-align: middle;white-space: nowrap;}
        table tbody td{text-align: center;vertical-align: middle;white-space: nowrap;word-wrap: break-word;}
    </style>
</head>

<body>

<section id="container" >
    <!-- **********************************************************************************************************************************************************
    TOP BAR CONTENT & NOTIFICATIONS
    *********************************************************************************************************************************************************** -->
    <!--header start-->
    <header class="header black-bg">
        <div class="sidebar-toggle-box">
            <div class="fa fa-bars tooltips" data-placement="right" ></div>
        </div>
        <!--logo start-->
        <a class="logo"><b>${loginuser.comp}</b></a>
        <!--logo end-->
        <div class="top-menu">
            <ul class="nav pull-right top-menu">
                <li><a class="logout" href="${basePath}/sms/logout">退出系统</a></li>
            </ul>
        </div>
    </header>
    <!--header end-->
    <!-- **********************************************************************************************************************************************************
    MAIN SIDEBAR MENU
    *********************************************************************************************************************************************************** -->
    <!--sidebar start-->
    <aside>
        <div id="sidebar"  class="nav-collapse ">
            <!-- sidebar menu start-->
            <ul class="sidebar-menu" id="nav-accordion">
                <p class="centered"><a href="javascript:;"><img src="${basePath}/assets/img/ui-sam.jpg" class="img-circle" width="60"></a></p>
                <h5 class="centered">${loginuser.userName}</h5>
                <c:forEach items="${rootPermission.children}" var="permission">
                    <c:if test="${empty permission.children}">
                        <li class="mt" >
                            <a href="${basePath}${permission.url}"><i class="fa fa-dashboard"></i>${permission.name}</a>
                        </li>
                    </c:if>
                    <c:if test="${not empty permission.children}">
                        <li class="sub-menu">
                            <a  href="javascript:;"><i class="fa fa-desktop"></i><span>${permission.name}</span></a>
                            <ul class="sub">
                                <c:forEach items="${permission.children}" var="child">
                                    <li>
                                        <a href="${basePath}${child.url}">${child.name}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </li>
                    </c:if>
                </c:forEach>
            </ul>
            <!-- sidebar menu end-->
        </div>
    </aside>
    <!--sidebar end-->

    <!-- **********************************************************************************************************************************************************
    MAIN CONTENT
    *********************************************************************************************************************************************************** -->
    <!--main content start-->
    <section id="main-content">
        <section class="wrapper">
            <h3><i class="fa fa-angle-right"></i>通道管理/通道信息</h3>
            <div class="row mt">
                <div class="col-lg-12 col-xs-12">
                    <div class="content-panel">
                        <h4><i class="fa fa-angle-right"></i>新增通道</h4>
                        <section id="unseen">
                            <div class="panel panel-default">
                                <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"></div></div>
                                <div class="panel-body">
                                    <form role="form" action="${basePath}/cp/savechannel" method="post">
                                        <div class="form-group">
                                            <label for="exampleInputPassword1">通道名称</label>
                                            <input type="text" class="form-control" id="exampleInputPassword1" placeholder="请输入通道名称">
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputPassword16">通道别名</label>
                                            <input type="text" class="form-control" id="exampleInputPassword16" placeholder="请输入通道别名，不能存在汉字">
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputPassword2">账号</label>
                                            <input type="text" class="form-control" id="exampleInputPassword2" placeholder="请输入账号">
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputPassword3">密码</label>
                                            <input type="text" class="form-control" id="exampleInputPassword3" placeholder="请输入密码">
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputPassword5">连接数</label>
                                            <input type="text" class="form-control" id="exampleInputPassword5" placeholder="cmpp必需">
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputPassword6">码号</label>
                                            <input type="text" class="form-control" id="exampleInputPassword6" placeholder="请输入码号">
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputPassword7">通道权重</label>
                                            <input type="text" class="form-control" id="exampleInputPassword7" placeholder="请输入通道权重">
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputPassword8">发送速率</label>
                                            <input type="text" class="form-control" id="exampleInputPassword8" placeholder="请输入发送速率">
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputPassword10">ip地址</label>
                                            <input type="text" class="form-control" id="exampleInputPassword10" placeholder="cmpp方式">
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputPassword9">端口号</label>
                                            <input type="text" class="form-control" id="exampleInputPassword9" placeholder="cmpp方式">
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputPassword14">通道地址</label>
                                            <input type="text" class="form-control" id="exampleInputPassword14" placeholder="http方式">
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputPassword15">秘钥</label>
                                            <input type="text" class="form-control" id="exampleInputPassword15" placeholder="http方式">
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputPassword11">通道接入方式</label>
                                            <input type="text" class="form-control" id="exampleInputPassword11" placeholder="cmppv2或http">
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputPassword12">通道屏蔽地区</label>
                                            <input type="text" class="form-control" id="exampleInputPassword12" placeholder="请输入通道屏蔽地区">
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputPassword13">价格</label>
                                            <input type="text" class="form-control" id="exampleInputPassword13" placeholder="请输入价格">
                                        </div>
                                        <button type="button" class="btn btn-success" onclick="addchannel();"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                                        <button type="reset" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i>重置</button>
                                    </form>
                                </div>
                            </div>
                        </section>
                    </div>
                </div><!-- /col-lg-9 END SECTION MIDDLE -->

                <!-- **********************************************************************************************************************************************************
                RIGHT SIDEBAR CONTENT
                *********************************************************************************************************************************************************** -->
            </div><! --/row -->
        </section>
    </section>

    <!--main content end-->
</section>

<!-- js placed at the end of the document so the pages load faster -->
<script src="${basePath}/assets/js/jquery.js"></script>
<script src="${basePath}/assets/js/bootstrap.min.js"></script>
<script class="include" type="text/javascript" src="${basePath}/assets/js/jquery.dcjqaccordion.2.7.js"></script>
<script src="${basePath}/assets/js/jquery.scrollTo.min.js"></script>
<script src="${basePath}/assets/js/jquery.nicescroll.js" type="text/javascript"></script>
<!--common script for all pages-->
<script src="${basePath}/assets/js/common-scripts.js"></script>
<script src="${basePath}/layer/layer.js"></script>
<!--script for this page-->
<script>
    function addchannel() {
        var account = $("#exampleInputPassword1").val();
        var name = $("#exampleInputPassword2").val();
        var passWord = $("#exampleInputPassword3").val();
        var connections = $("#exampleInputPassword5").val();
        var srcId = $("#exampleInputPassword6").val();
        var weight = $("#exampleInputPassword7").val();
        var flowRate = $("#exampleInputPassword8").val();
        var port = $("#exampleInputPassword9").val();
        var ip = $("#exampleInputPassword10").val();
        var accessMode = $("#exampleInputPassword11").val();
        var limitarea = $("#exampleInputPassword12").val();
        var price = $("#exampleInputPassword13").val();
        var url  = $("#exampleInputPassword14").val();
        var keyWord = $("#exampleInputPassword15").val();
        var alias = $("#exampleInputPassword16").val();

        var loadingIndex = null;
        if(account == ""){
            layer.msg("通道名称不能为空，请输入通道名称", {time:2000, icon:5, shift:2}, function(){});
            return;
        }
        if(alias == ""){
            layer.msg("通道别名不能为空，请输入通道别名", {time:2000, icon:5, shift:2}, function(){});
            return;
        }
        if(name == ""){
            layer.msg("通道账户不能为空，请输入账户", {time:2000, icon:5, shift:2}, function(){});
            return;
        }
        if(passWord == ""){
            layer.msg("通道账户密码不能为空，请输入密码", {time:2000, icon:5, shift:2}, function(){});
            return;
        }
        if(weight == ""){
            layer.msg("通道权重不能为空，请输入通道权重", {time:2000, icon:5, shift:2}, function(){});
            return;
        }
        if(flowRate == ""){
            layer.msg("发送速率不能为空，请输入发送速率", {time:2000, icon:5, shift:2}, function(){});
            return;
        }

        if(accessMode == ""){
            layer.msg("通道接入方式不能为空，请输入通道接入方式", {time:2000, icon:5, shift:2}, function(){});
            return;
        }
        if(limitarea == ""){
            layer.msg("通道屏蔽地区不能为空，请输入屏蔽地区", {time:2000, icon:5, shift:2}, function(){});
            return;
        }
        if(price == ""){
            layer.msg("通道价格不能为空，请输入价格", {time:2000, icon:5, shift:2}, function(){});
            return;
        }
        if (accessMode == "http"){
            if(url == ""){
                layer.msg("通道地址不能为空，请输入通道地址", {time:2000, icon:5, shift:2}, function(){});
                return;
            }
            if(keyWord == ""){
                layer.msg("秘钥不能为空，请输入秘钥", {time:2000, icon:5, shift:2}, function(){});
                return;
            }
        }
        if (accessMode == "cmppv2") {
            if(connections == ""){
                layer.msg("通道连接数不能为空，请输入连接数", {time:2000, icon:5, shift:2}, function(){});
                return;
            }
            if(ip == ""){
                layer.msg("ip地址不能为空，请输入ip地址", {time:2000, icon:5, shift:2}, function(){});
                return;
            }
            if(port == ""){
                layer.msg("端口号不能为空，请输入端口号", {time:2000, icon:5, shift:2}, function(){});
                return;
            }
        }
        //提交表单数据
        $.ajax({
            type:"POST",
            url:"${basePath}/channel/savechannel",
            data:JSON.stringify({"account":account,"alias":alias,"name":name,"passWord":passWord,"connections":connections,"flowRate":flowRate,"accessMode":accessMode,"ip":ip,"srcId":srcId,"weight":weight,"port":port,"limitArea":limitarea,"price":price,"url":url,"keyWord":keyWord}),
            contentType:"application/json;charset=UTF-8",
            beforeSend:function () {
                loadingIndex =  layer.msg('处理中...', {icon: 16});
            },
            success:function (result) {
                if (result.success){
                    layer.msg("新增通道成功！", {time:3000, icon:6, shift:2}, function(){});
                    window.setTimeout("window.location.href='${basePath}/channel/channelmsg'",2000);
                }else if(result.repeatChannel){
                    layer.msg("通道已存在！", {time:2000, icon:5, shift:6}, function(){});
                }else{
                    layer.msg("新增通道失败！", {time:2000, icon:5, shift:6}, function(){});
                }
            }
        });

    }
</script>
</body>
</html>

