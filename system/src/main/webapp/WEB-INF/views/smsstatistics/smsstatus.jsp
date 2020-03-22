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
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	<link rel="stylesheet" href="${basePath}/bootstrap/css/zebra_tooltips.css">
	<!-- Custom styles for this template -->
	<link href="${basePath}/assets/css/style.css" rel="stylesheet">
	<link href="${basePath}/assets/css/style-responsive.css" rel="stylesheet">
	<script src="${basePath}/assets/js/jquery.js"></script>
	<script src="${basePath}/bootstrap/js/jqpaginator.min.js"></script>
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
			<h3><i class="fa fa-angle-right"></i>统计查询/短信状态查询</h3>
			<div class="row mt">
				<div class="col-lg-12 col-xs-12">
					<h4><i class="fa fa-angle-right"></i>短信状态</h4>
					<%--<div class="panel-heading">--%>
					<%--<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i>短信发送审核列表</h3>--%>
					<%--</div>--%>
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-4 col-md-4 col-sm-4 mb">
								<div style="font-size: large">手机号码</div>
								<input class="form-control has-success" type="text" id="statusmobile">
							</div>
							<div class="col-lg-4 col-md-4 col-sm-4 mb">
								<div style="font-size: large">起始时间</div>
								<%--<input class="form-control has-success" type="text">--%>
								<div class="input-group date form_date" data-date="" data-date-format="yyyy-mm-dd" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
									<input class="form-control formattime" type="text" value="" placeholder="" id="begintime">
									<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
									<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
								</div>
								<input type="hidden" id="dtp_input2" value="" />
							</div>
							<div class="col-lg-4 col-md-4 col-sm-4 mb">
								<div style="font-size: large">起止时间</div>
								<%--<input class="form-control has-success" type="text">--%>
								<div class="input-group date form_date_1" data-date="" data-date-format="yyyy-mm-dd" data-link-field="dtp_input3" data-link-format="yyyy-mm-dd">
									<input class="form-control formattime" type="text" value="" placeholder="" id="endtime">
									<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
									<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
								</div>
								<input type="hidden" id="dtp_input3" value=""/>
							</div>
							<div class="col-lg-4 col-md-4 col-sm-4 mb">
								<button type="button" class="btn btn-warning" onclick="checkstatus(1);"><i class="glyphicon glyphicon-search"></i>查询</button>
							</div>
						</div>
					</div>
				</div><!-- /col-lg-9 END SECTION MIDDLE -->
				<div class="table-responsive">
					<table class="table  table-bordered">
						<thead>
						<tr >
							<th width="30">#</th>
							<th width="30"><input type="checkbox"></th>
							<th>手机号码</th>
							<th>号码归属</th>
							<th>运营商</th>
							<th>渠道</th>
							<th>通道</th>
							<th>短信内容</th>
							<th>提交时间</th>
							<th>发送时间</th>
							<th>回调时间</th>
							<th>状态</th>
							<th>同步</th>
						</tr>
						</thead>
						<tbody class="statustmsg">

						</tbody>

						<tfoot class="statusfoot">

						</tfoot>
					</table>
				</div>

				<!-- **********************************************************************************************************************************************************
                RIGHT SIDEBAR CONTENT
                *********************************************************************************************************************************************************** -->
			</div><! --/row -->
		</section>
	</section>
	<!--main content end-->
</section>

<!-- js placed at the end of the document so the pages load faster -->

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
<script src="${basePath}/bootstrap/js/zebra_tooltips.min.js"></script>

<!--script for this page-->
<script>

	$('.form_date').datetimepicker({
		language: 'zh-CN',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 2,
		forceParse: 0
	});
	$('.form_date_1').datetimepicker({
		language: 'zh-CN',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 2,
		forceParse: 0
	});
	$('.form_date').datetimepicker("setDate", new Date());
	$('.form_date_1').datetimepicker("setDate", new Date());

	//查询数据
	function checkstatus(pageNum) {
		var loadingIndex = null;
		var mobile = $("#statusmobile").val();
		var begintime = $("#begintime").val();
		var endtime = $("#endtime").val();

		if(begintime == ""){
			layer.msg("起始不能为空，请选择起始时间", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		if(endtime == ""){
			layer.msg("起止不能为空，请选择起止时间", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		if(mobile == ""){
			layer.msg("手机号码不能为空，请输入手机号码", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		$.ajax({
			type:"GET",
			url:"${basePath}/statistical/checkmobilestatus",
			data:{"mobile":mobile,"begintime":begintime,"endtime":endtime,"pageNum":pageNum},
			beforeSend:function () {
				loadingIndex =  layer.msg('查询中...', {time:10000, icon:16, shift:10});
			},
			success:function (result) {
				layer.close(loadingIndex);
				//清空表格数据
				$(".statustmsg").empty();
				$(".statusfoot").empty();
				//总页码
				var totalPage = result.totalPage;
				//当前页码
				var pageNum = result.pageNum;
				var pageSize = result.pageSize;
				var countNum = result.countNum;
				if (totalPage == 0 && countNum == 0){
					totalPage =1;
				}
				//数据
				var dataStr = result.data;
				//动态生成表格数据
				for (var i = 0; i < dataStr.length ; i++) {
					var opTime = "";
					var sendTime = "";
					var notifyTime = "";
					var city = "";
					var carrier = "";
					var statusCp = "";
					var statusChannel = "";
					var statusSendContent = "";
					var result = "";
					var isshow = "";
					if (dataStr[i].operateTime != null) {
						opTime = timeStamp(dataStr[i].operateTime);
					}
					if (dataStr[i].sendTime != null && dataStr[i].sendTime != "") {
						sendTime = timeStamp(dataStr[i].sendTime);
					}
					if (dataStr[i].notifyTime != null) {
						notifyTime = timeStamp(dataStr[i].notifyTime);
					}
					if (dataStr[i].city != null) {
						city = dataStr[i].city;
					}
					if (dataStr[i].carrier != null) {
						carrier = dataStr[i].carrier;
					}
					if (dataStr[i].statusCp != null) {
						statusCp = dataStr[i].statusCp;
					}
					if (dataStr[i].statusChannel != null) {
						statusChannel = dataStr[i].statusChannel;
					}
					if (dataStr[i].sendContent != null) {
						statusSendContent = dataStr[i].sendContent;
					}
					if (dataStr[i].result != null) {
						result = dataStr[i].result;
						if (result == "0"){
							result = "成功";
						}else if (result == "1"){
							result = "失败";
						}
					}
					if (dataStr[i].isshow != null) {
						isshow = dataStr[i].isshow;
						if (isshow == "0"){
							isshow = "同步";
						}else if (isshow == "1"){
							isshow = "不同步";
						}
					}

					$(".statustmsg").append("<tr class='statu_tr'>" +
							"<td>"+(i+1)+"</td>" +
							"<td><input type='checkbox' ></td>" +
							"<td>"+dataStr[i].mobile+"</td>" +
							"<td>"+city+"</td>" +
							"<td>"+carrier+"</td>" +
							"<td>"+statusCp+"</td>" +
							"<td>"+statusChannel+"</td>" +
							"<td id='statu_"+i+"' title='"+statusSendContent+"'>"+statusSendContent+"</td>" +
							"<td>"+opTime+"</td>" +
							"<td>"+sendTime+"</td>" +
							"<td>"+notifyTime+"</td>" +
							"<td>"+result+"</td>" +
							"<td>"+isshow+"</td></tr>");
				}

				//处理短信内容过长展示
				var tr = $(".statu_tr");
				for (var i = 0; i < tr.length ; i++) {

					new $.Zebra_Tooltips($("#statu_"+i+""));
					var td = $("#statu_"+i+"").text();
					if (td.length > 5) {
						//给td设置title属性,并且设置td的完整值.给title属性.
						// $("#content_"+i+"").attr("title",td);
						//获取td的值,进行截取。赋值给text变量保存.
						var text=td.substring(0,5)+"...";
						//重新为td赋值;
						$("#statu_"+i+"").text(text);
					}
				}
				$(".statusfoot").append("<tr><td colspan='13' align='center'><ul class='pagination' id='statusmsgpage'></ul><ul id='statuspagecount'></ul></td></tr>");
				//使用插件分页
				$.jqPaginator('#statusmsgpage', {
					totalPages: totalPage,
					visiblePages: pageSize,
					currentPage: pageNum,
					first: '<li class="first"><a href="javascript:void(0);">首页</a></li>',
					prev: '<li class="prev"><a href="javascript:;">上一页</a></li>',
					next: '<li class="next"><a href="javascript:void(0);">下一页</a></li>',
					last: '<li class="last"><a href="javascript:void(0);">尾页</a></li>',
					page: '<li class="page"><a href="javascript:;">{{page}}</a></li>',
					onPageChange: function (num, type) {
						if (type == "change"){
							checkstatus(num);
						}
					}
				});
				$("#statuspagecount").append("<li><span>共"+totalPage+"页"+countNum+"条记录</span></li>")
			}
		});
	}

	function timeStamp(dateStamp){
		let date = new Date(dateStamp);
		let Y = date.getFullYear() + '-';
		let M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-';
		let D = (date.getDate() < 10 ? '0' + date.getDate() : date.getDate()) + ' ';
		let H = (date.getHours() < 10 ? '0' + date.getHours() : date.getHours()) + ':';
		let Mi = (date.getMinutes() < 10 ? '0' + date.getMinutes() : date.getMinutes()) + ':';
		let S = (date.getSeconds() < 10 ? '0' + date.getSeconds() : date.getSeconds());
		let tempDate = Y + M + D + H + Mi + S;
		console.log("时间戳转换", tempDate)
		return tempDate;
	}
</script>
</body>
</html>

