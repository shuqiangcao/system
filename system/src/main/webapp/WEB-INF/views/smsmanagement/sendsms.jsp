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
    <link rel="stylesheet" href="${basePath}/datetimepicket/css/bootstrap-datetimepicker.css">
    <link rel="stylesheet" href="${basePath}/bootstrap/css/select-mania.css">
    <link rel="stylesheet" href="${basePath}/bootstrap/css/select-mania-theme-darkblue.css">
    <!-- Custom styles for this template -->
    <link href="${basePath}/assets/css/style.css" rel="stylesheet">
    <link href="${basePath}/assets/css/style-responsive.css" rel="stylesheet">
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
            <h3><i class="fa fa-angle-right"></i>短信管理/短信发送</h3>
            <div class="row mt">
                <div class="col-lg-12 col-xs-12">
                    <div class="content-panel">
                        <h4><i class="fa fa-angle-right"></i>短信发送数据</h4>
                        <section id="unseen">
                            <div class="panel panel-default">
                                <%--<div class="panel-heading">短信发送数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"></div></div>--%>
                                <div class="panel-body">
                                    <form role="form" action="${basePath}/user/saveuser" method="post">
                                        <input type="hidden" value="${userRoleId}" id="userroleid">
                                        <div class="form-group">
                                            <label for="dtp_input1" class="control-label">发送时间</label><br>
                                            <div style="width: 100%" class="input-group date form_datetime" data-date-format="yyyy-mm-dd hh:ii" data-link-field="dtp_input1">
                                                <input style="width: 100%" id="sendtime" class="form-control formattime" type="text" value="" placeholder="请选择发送时间">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
                                            </div>
                                            <input type="hidden" id="dtp_input1" value="" /><br/>
                                        </div>
                                        <div class="form-group">
                                            <label for="sendmobile">发送号码</label>
                                            <textarea class="form-control" id="sendmobile" placeholder="请输入发送号码,号码之间英文逗号分隔"></textarea>
                                        </div>
                                        <div class="form-group">
                                            <label for="mobiletaskid">号码批次号</label>
                                            <input class="form-control" id="mobiletaskid"/>
                                            <p class="help-block label label-warning">号码批次号自定义,不重复，同一批号码批次号必须相同</p>
                                        </div>
                                        <div class="form-group">
                                            <label for="sendcp">渠道</label>
                                            <select class="cp" id="sendcp">
                                                <option value="" selected>请选择渠道</option>
                                                <c:forEach items="${smsCps}" var="item" varStatus="status">
                                                    <option value="${item.account}">${item.account}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label for="sendtemplate">模板</label>
                                            <%--<input type="text" class="form-control" id="template" placeholder="请选择模板">--%>
                                            <select class="template" id="sendtemplate" onchange="templatemsg();">
                                                <option value="" selected>请选择模板</option>
                                                <c:forEach items="${smsTemplates}" var="item" varStatus="status">
                                                    <option value="${item.id}">${item.templateId}+${item.templateName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="form-group" id="channeldiv">
                                            <label for="channel">通道</label>
                                            <input type="text" class="form-control" id="channel" readonly="readonly">
                                        </div>
                                        <div class="form-group" id="pricediv">
                                            <label for="price">价格</label>
                                            <input type="text" class="form-control" id="price" readonly="readonly">
                                        </div>
                                        <div class="form-group">
                                            <label for="smscontent">短信内容</label>
                                            <textarea class="form-control" id="smscontent" readonly="readonly"></textarea>
                                            <%--<p class="help-block label label-warning">如发送变量短信, 变量间使用|分隔： 变量1|变量2</p>--%>
                                        </div>
                                        <div class="form-group">
                                            <label for="smsvariable">短信变量</label>
                                            <input class="form-control" id="smsvariable"/>
                                            <p class="help-block label label-warning">如发送变量短信, 变量间使用|分隔： 变量1|变量2</p>
                                        </div>
                                        <button type="button" id="btnsend" class="btn btn-success" onclick="sendSms();"><i class="glyphicon glyphicon-plus"></i>提交</button>
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
<script src="${basePath}/datetimepicket/js/bootstrap-datetimepicker.js"></script>
<script src="${basePath}/datetimepicket/js/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="${basePath}/bootstrap/js/select-mania.js"></script>
<!--script for this page-->
<script>
    //超级管理员展示通道和价格，其他隐藏
    $(function () {
        var roleid = $("#userroleid").val();
        if (roleid == 1){
            $("#channeldiv").show();
            $("#pricediv").show();
        }else{
            $("#channeldiv").hide();
            $("#pricediv").hide();
        }
    });

    function templatemsg(){
        //清空原值
        $("#channel").attr("value","");
        $("#price").attr("value","");
        $("#smscontent").val("");

        var id = $("#sendtemplate").val();
        $.ajax({
            type:"GET",
            url:"${basePath}/send/checktemplate",
            data:{"id":id},
            success:function(result){
                if (result.success){
                    var resultStr = result.data;
                    //赋值
                    $("#channel").attr("value",resultStr.channel);
                    $("#price").attr("value",resultStr.price);
                    //判断模板是否是变量模板
                    // if (resultStr.sendContent.indexOf("{") != -1 && resultStr.sendContent.indexOf("}") != -1) {
                    //     $("#smscontent").attr("readOnly",false);
                    // }else{
                    //     $("#smscontent").attr("readOnly",true);
                    //     $("#smscontent").val(resultStr.sendContent);
                    // }
                    $("#smscontent").attr("readOnly",true);
                    $("#smscontent").val(resultStr.sendContent);
                }else{
                    layer.msg("选择模板失败！", {time:3000, icon:6, shift:2}, function(){});
                }
            }
        });
    }

    $('.cp').selectMania({
        //size: 'large',
        themes: ['darkblue'],
        placeholder: '请选择渠道',
        removable: true,
        search: true
    });
    $('.template').selectMania({
        //size: 'large',
        themes: ['darkblue'],
        placeholder: '请选择模板',
        removable: true,
        search: true
    });

    $('.form_datetime').datetimepicker({
        language: 'zh-CN',
        weekStart: 1,
        todayBtn:  1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        forceParse: 0,
        showMeridian: 1
    });

    $(function () {
        $(".list-group-item").click(function(){
            if ( $(this).find("ul") ) {
                $(this).toggleClass("tree-closed");
                if ( $(this).hasClass("tree-closed") ) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
    });
    function sendSms() {
        $("#btnsend").attr("disabled",true);
        var sendtime = $("#sendtime").val();
        var sendmobile = $("#sendmobile").val();
        var sendcp = $("#sendcp").val();
        var tempid = $("#sendtemplate").val();
        var sendtemplateId = $("#sendtemplate option:selected").text();
        sendtemplateId = sendtemplateId.split("+")[0];  //截取模板id
        var channel = $("#channel").val();
        var price = $("#price").val();
        var smscontent = $("#smscontent").val();
        var smsvariable = $("#smsvariable").val();
        var mobiletaskid = $("#mobiletaskid").val();

        var loadingIndex = null;
        if(sendmobile == ""){
            layer.msg("发送号码不能为空，请输入发送号码", {time:2000, icon:5, shift:2}, function(){});
            return;
        }
        if(sendcp == ""){
            layer.msg("渠道不能为空，请选择渠道", {time:2000, icon:5, shift:2}, function(){});
            return;
        }
        if(tempid == ""){
            layer.msg("短信模板不能为空，请选择模板", {time:2000, icon:5, shift:2}, function(){});
            return;
        }
        if(channel == ""){
            layer.msg("通道不能为空，请检查是否已选择模板", {time:2000, icon:5, shift:2}, function(){});
            return;
        }
        if(price == ""){
            layer.msg("价格不能为空，请检查是否已选择模板", {time:2000, icon:5, shift:2}, function(){});
            return;
        }
        if(smscontent == ""){
            layer.msg("短信内容不能为空，请检查是否已选择模板", {time:2000, icon:5, shift:2}, function(){});
            return;
        }
        if(mobiletaskid == ""){
            layer.msg("号码批次号不能为空，请填写号码批次号", {time:2000, icon:5, shift:2}, function(){});
            return;
        }
        //提交表单数据
        $.ajax({
            type:"POST",
            url:"${basePath}/send/submitsms",
            data:JSON.stringify({"templateId":sendtemplateId,"cp":sendcp,"channel":channel,"mobile":sendmobile,"price":price,"sendTime":sendtime,"variable":smsvariable,"taskId":mobiletaskid}),
            contentType:"application/json;charset=UTF-8",
            beforeSend:function () {
                loadingIndex =  layer.msg('处理中...', {time:600000, icon:16, shift:10});
            },
            success:function (result) {
                layer.close(loadingIndex);
                if (result.success){
                    layer.msg("提交短信成功！", {time:3000, icon:6, shift:2}, function(){});
                    window.setTimeout("window.location.href='${basePath}/send/sendsms'",2000);
                }else if(result.repeatSubmit){
                    layer.msg("此批次号码已成功提交,忽重复提交！", {time:3000, icon:6, shift:2}, function(){});
                    window.setTimeout("window.location.href='${basePath}/send/sendsms'",2000);
                }else{
                    layer.msg("提交短信失败！", {time:2000, icon:5, shift:6}, function(){});
                }
            }
        });

    }
</script>
</body>
</html>

