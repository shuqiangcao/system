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
		.modal-body {
			overflow-x: auto;
		}

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
			<h3><i class="fa fa-angle-right"></i>统计查询/短信发送记录</h3>
			<div class="row mt">
				<div class="col-lg-12 col-xs-12">
					<h4><i class="fa fa-angle-right"></i>发送记录</h4>
					<%--<div class="panel-heading">--%>
					<%--<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i>短信发送审核列表</h3>--%>
					<%--</div>--%>
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-4 col-md-4 col-sm-4 mb">
								<div style="font-size: large">账号</div>
								<%--<input class="form-control has-success" type="text">--%>
								<select class="form-control recordcp" id="recordcp">
									<option value="" selected>全部</option>
									<c:forEach items="${smsCps}" var="item" varStatus="status">
										<option value="${item.account}">${item.account}</option>
									</c:forEach>
								</select>
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
								<button type="button" class="btn btn-warning" onclick="checksendrecord(1);"><i class="glyphicon glyphicon-search"></i>查询</button>
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
							<th>账号</th>
							<th>批次</th>
							<th>提交号码数</th>
							<th>发送号码数</th>
							<th>成功号码数</th>
							<th>提交时间</th>
							<th>发送时间</th>
							<th>完成时间</th>
							<th colspan="3">操作</th>
						</tr>
						</thead>
						<tbody class="recordmsg">
						<c:forEach items="${result.data}" var="item" varStatus="status">
							<tr class="record_tr">
								<td>${status.index+1}</td>
								<td><input type="checkbox"></td>
								<td>${item.cp}</td>
								<td>${item.id}</td>
								<td>${item.sendCount}</td>
								<td>${item.submitCount}</td>
								<td>${item.sendSuccessCount}</td>
								<td><fmt:formatDate value="${item.operateTime}" type="both"/></td>
								<td><fmt:formatDate value="${item.detailSendTime}" type="both"/></td>
								<td><fmt:formatDate value="${item.notifyTime}" type="both"/></td>
								<td>
									<button type="button" class="btn btn-primary btn-xs" onclick="infoMsg(${item.id},1);"><i>批次详情</i></button>
								</td>
								<td>
									<button type="button" class="btn btn-primary btn-xs" onclick="exportmsg(${item.id});"><i>导出详情</i></button>
								</td>
                                <td>
                                    <button type="button" class="btn btn-primary btn-xs" onclick="mobilefilter(${item.id});"><i>号码过滤详情</i></button>
                                </td>
							</tr>
						</c:forEach>
						</tbody>

						<tfoot class="recordfoot">
						<tr >
							<td colspan="13" align="center">
								<ul class="pagination" id="querymsgpage">
									<input type="hidden" value="${result.totalPage}" id="totalpage">
									<input type="hidden" value="${result.pageNum}" id="pagenum">
									<input type="hidden" value="${result.pageSize}" id="pagesize">
									<input type="hidden" value="${result.countNum}" id="countnum">
								</ul>
								<ul id="querypagecount">
								</ul>
							</td>
						</tr>
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
<%--批次详情--%>
<div style="width: 100%;height: 100%;">
	<%--data-backdrop="static"  禁止点击空白处关闭弹窗--%>
	<div class="modal fade" id="infoModal" tabindex="-1" role="dialog" data-backdrop="static">
		<%--设置宽度1000不能适配手机--%>
		<%--<div class="modal-dialog" style="width:1000px">--%>
			<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">批次详情</h4>
				</div>
				<div class="modal-body" style="height: 700px;">
					<input type="hidden" value="" id="checkinfoId">
					<div class="row mt">
						<div class="col-lg-12 col-xs-12">
							<div class="row">
								<div class="col-lg-6 col-md-6 col-sm-6 mb">
									<div style="font-size: large">状态</div>
									<%--<input class="form-control has-success" type="text">--%>
									<select class="form-control" id="checkselect">
										<option style="font-size: large" value="" selected>全部</option>
										<option style="font-size: large" value="0">成功</option>
										<option style="font-size: large" value="1">失败</option>
									</select>
								</div>
								<div class="col-lg-6 col-md-6 col-sm-6 mb">
									<div style="font-size: large">手机号码</div>
									<input class="form-control has-success" type="text" id="checkmobile">
								</div>
								<div class="col-lg-6 col-md-6 col-sm-6 mb">
									<button type="button" class="btn btn-warning" onclick="checkinfomsg(1);"><i class="glyphicon glyphicon-search"></i>查询</button>
								</div>
							</div>
								<div class="table-responsive">
								<table class="table table-bordered table-striped table-condensed">
									<thead>
									<tr>
										<th>手机号</th>
										<th>归属地</th>
										<th>运营商</th>
										<th>发送内容</th>
										<th>渠道</th>
										<th>通道</th>
										<th>状态</th>
										<th>同步</th>
									</tr>
									</thead>
									<tbody class="infomsg">
									</tbody>
									<tfoot class="infofoot">
									</tfoot>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<%--号码过滤详情--%>
<div style="width: 100%;height: 100%;">
    <%--data-backdrop="static"  禁止点击空白处关闭弹窗--%>
    <div class="modal fade" id="mobilefilterModal" tabindex="-1" role="dialog" data-backdrop="static">
        <%--设置宽度1000不能适配手机--%>
        <%--<div class="modal-dialog" style="width:1000px">--%>
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="mymobilefilterModalLabel">号码过滤详情</h4>
                </div>
                <div class="modal-body" style="height: 200px;">
                    <input type="hidden" value="" id="mobilefiltercheckinfoId">
                    <div class="row mt">
                        <div class="col-lg-12 col-xs-12">
                            <div class="table-responsive">
                                <table class="table table-bordered table-striped table-condensed">
                                    <thead>
                                    <tr>
                                        <th>黑名单</th>
                                        <th>通道错误</th>
                                        <th>发送限次</th>
                                        <th>发送限速</th>
                                        <th>屏蔽字</th>
                                        <th>号码错误</th>
                                        <th>金额不足</th>
                                        <th>省份限制</th>
                                        <th>短信模板错误</th>
                                        <th>总计</th>
                                    </tr>
                                    </thead>
                                    <tbody class="mobilefiltermsg">
                                    </tbody>
                                    <tfoot class="mobilefilterfoot">
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

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
	//使用插件分页
	var pagesum = $("#totalpage").val();
	var pageindex = $("#pagenum").val();
	var pagesize = $("#pagesize").val();
	var countnum = $("#countnum").val();
	if (pagesum == 0 && countnum == 0){
		pagesum = 1;
	}
	$.jqPaginator('#querymsgpage', {
		totalPages: parseInt(pagesum),
		visiblePages: parseInt(pagesize),
		currentPage: parseInt(pageindex),
		first: '<li class="first"><a href="javascript:void(0);">首页</a></li>',
		prev: '<li class="prev"><a href="javascript:;">上一页</a></li>',
		next: '<li class="next"><a href="javascript:void(0);">下一页</a></li>',
		last: '<li class="last"><a href="javascript:void(0);">尾页</a></li>',
		page: '<li class="page"><a href="javascript:;">{{page}}</a></li>',
		onPageChange: function (num, type) {
			if (type == "change"){
				changePageNum(num);
			}
		}
	});
	$("#querypagecount").append("<li><span>共"+pagesum+"页"+countnum+"条记录</span></li>")
</script>
<script>

	//监听批次详情模拟框事件，关闭之后清除弹窗数据
	$('#infoModal').on('hidden.bs.modal', function (){
		$("#checkmobile").val("");
		$("#checkselect").find("option:selected").attr("selected",false);
		$("#checkselect").find("option").first().attr("selected",true);
	});

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
	//翻页
	function changePageNum(pageNum){
		window.location.href = "${basePath}/statistical/querymsg?pageNum="+pageNum;
	}

	//条件查询数据
	function checksendrecord(pageNum) {
		var loadingIndex = null;
		var cp = $("#recordcp").val();
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
		$.ajax({
			type:"GET",
			url:"${basePath}/statistical/checkrecord",
			data:{"cp":encodeURIComponent(cp),"begintime":begintime,"endtime":endtime,"pageNum":pageNum},
			beforeSend:function () {
				loadingIndex =  layer.msg('查询中...', {time:120000, icon:16, shift:10});
			},
			success:function (result) {
				layer.close(loadingIndex);
				//清空表格数据
				$(".recordmsg").empty();
				$(".recordfoot").empty();
				//总页码
				var totalPage = result.totalPage;
				//当前页码
				var pageNum = result.pageNum;
				var pageSize = result.pageSize;
				var countNum = result.countNum;
				if (totalPage == 0 && countNum == 0){
					totalPage = 1;
				}
				//数据
				var dataStr = result.data;
				//动态生成表格数据
				for (var i = 0; i < dataStr.length ; i++) {
					var opTime = "";
					var sendTime = "";
					var notifyTime = "";
					if (dataStr[i].operateTime != null) {
						opTime = timeStamp(dataStr[i].operateTime);
					}
					if (dataStr[i].detailSendTime != null) {
						sendTime = timeStamp(dataStr[i].detailSendTime);
					}
					if (dataStr[i].notifyTime != null) {
						notifyTime = timeStamp(dataStr[i].notifyTime);
					}
					$(".recordmsg").append("<tr class='record_tr'>" +
							"<td>"+(i+1)+"</td>" +
							"<td><input type='checkbox' ></td>" +
							"<td>"+dataStr[i].cp+"</td>" +
							"<td>"+dataStr[i].id+"</td>" +
							"<td>"+dataStr[i].sendCount+"</td>" +
							"<td>"+dataStr[i].submitCount+"</td>" +
							"<td>"+dataStr[i].sendSuccessCount+"</td>" +
							"<td>"+opTime+"</td><td>"+sendTime+"</td>" +
							"<td>"+notifyTime+"</td>" +
							"<td><button style='button' class='btn btn-primary btn-xs' onclick=\"infoMsg('"+dataStr[i].id+"',1);\"><i>批次详情</i></button></td>" +
							"<td><button style='button' class='btn btn-primary btn-xs' onclick=\"exportmsg('"+dataStr[i].id+"');\"><i>导出详情</i></button></td>" +
                            "<td><button style='button' class='btn btn-primary btn-xs' onclick=\"mobilefilter('"+dataStr[i].id+"');\"><i>号码过滤详情</i></button></td>" +
                            "</tr>");
				}
				$(".recordfoot").append("<tr><td colspan='12' align='center'><ul class='pagination' id='recordmsgpage'></ul><ul id='recordpagecount'></ul></td></tr>");
				//使用插件分页
				$.jqPaginator('#recordmsgpage', {
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
							checksendrecord(num);
						}
					}
				});
				$("#recordpagecount").append("<li><span>共"+totalPage+"页"+countNum+"条记录</span></li>")
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

	function infoMsg(infoId,pageNum) {
		var loadingIndex = null;
		//条件查询需要的批次号参数
		$("#checkinfoId").val(infoId);
		$.ajax({
			type: "POST",
			url: "${basePath}/statistical/infomsg",
			data: {"infoId":infoId,"pageNum":pageNum},
			beforeSend:function () {
				loadingIndex =  layer.msg('查询中...', {time:120000, icon:16, shift:10});
			},
			success:function (result) {
				layer.close(loadingIndex);
				//清空表格数据
				$(".infomsg").empty();
				$(".infofoot").empty();
				//总记录数
				var countNum = result.countNum;
				//总页码
				var totalPage = result.totalPage;
				//当前页码
				var pageNum = result.pageNum;
				//每页展示的数据数
				var pageSize = result.pageSize;
				if (totalPage == 0 && countNum == 0){
					totalPage = 1;
				}

				//数据
				var dataStr = result.data;
				console.log(dataStr);
				//动态生成表格数据
				for (var i = 0; i < dataStr.length ; i++) {
					var status = dataStr[i].result;
					var isshow = dataStr[i].isshow;
					if (status == "0"){
						status = "成功";
					}
					if (isshow == "0"){
						isshow = "同步";
					}else{
						isshow = "不同步";
					}
					$(".infomsg").append("<tr class='info_tr'>" +
							"<td>"+dataStr[i].mobile+"</td>" +
							"<td>"+dataStr[i].city+"</td>" +
							"<td>"+dataStr[i].carrier+"</td>" +
							"<td id='info_"+i+"' title='"+dataStr[i].sendContent+"'>"+dataStr[i].sendContent+"</td>" +
							"<td>"+dataStr[i].cp+"</td>" +
							"<td>"+dataStr[i].channel+"</td>" +
							"<td>"+status+"</td>" +
							"<td>"+isshow+"</td>" +
							"</tr>");

					}

					//动态生成分页页码
					$(".infofoot").append("<tr><td colspan='12' align='center'><ul class='pagination' id='infomsgpage'></ul><ul id='infomsgpagecount'></ul></td></tr>");
					//使用插件分页
					$.jqPaginator('#infomsgpage', {
						totalPages: totalPage,
						visiblePages: pageSize,
						currentPage: pageNum,
						first: '<li class="first"><a href="javascript:void(0);">首页</a></li>',
						prev: '<li class="prev"><a href="javascript:;">上一页</a></li>',
						next: '<li class="next"><a href="javascript:void(0);">下一页</a></li>',
						last: '<li class="last"><a href="javascript:void(0);">尾页</a></li>',
						//page: '<li class="page"><a href="javascript:;">{{page}}</a></li>',
						onPageChange: function (num, type) {
							if (type == "change"){
								infoMsg(infoId,num);
							}
						}
					});
					$("#infomsgpagecount").append("<li><span>共"+totalPage+"页"+countNum+"条记录</span></li>")

					//处理短信内容过长展示
					var tr = $(".info_tr");
					for (var i = 0; i < tr.length ; i++) {

						new $.Zebra_Tooltips($("#info_"+i+""));
						var td = $("#info_"+i+"").text();
						if (td.length > 5) {
							//给td设置title属性,并且设置td的完整值.给title属性.
							// $("#content_"+i+"").attr("title",td);
							//获取td的值,进行截取。赋值给text变量保存.
							var text=td.substring(0,5)+"...";
							//重新为td赋值;
							$("#info_"+i+"").text(text);
						}
					}
			}
		});
		//展示批次详情模拟框
		$("#infoModal").modal();
	}

	//条件查询批次详情
	function checkinfomsg(pageNum){
		var loadingIndex = null;
		var checkinfoId = $("#checkinfoId").val();
		var checkselect = $("#checkselect").val();
		var checkmobile = $("#checkmobile").val();
		$.ajax({
			type:"POST",
			url:"${basePath}/statistical/checkinfomsg",
			data:{"infoId":checkinfoId,"resultstatus":checkselect,"mobile":checkmobile,"pageNum":pageNum},
			beforeSend:function () {
				loadingIndex =  layer.msg('查询中...', {time:120000, icon:16, shift:10});
			},
			success:function (result) {
				layer.close(loadingIndex);
				//清空表格数据
				$(".infomsg").empty();
				$(".infofoot").empty();
				//总记录数
				var countNum = result.countNum;
				//总页码
				var totalPage = result.totalPage;
				//当前页码
				var pageNum = result.pageNum;
				//每页展示的数据数
				var pageSize = result.pageSize;
				if (totalPage == 0 && countNum == 0){
					totalPage = 1;
				}

				//数据
				var dataStr = result.data;
				console.log(dataStr);
				//动态生成表格数据
				for (var i = 0; i < dataStr.length ; i++) {
					var status = dataStr[i].result;
					var isshow = dataStr[i].isshow;
					if (status == "0"){
						status = "成功";
					}
					if (isshow == "0"){
						isshow = "同步";
					}else{
						isshow = "不同步";
					}
					$(".infomsg").append("<tr class='info_tr'>" +
							"<td data-title='手机号'>"+dataStr[i].mobile+"</td>" +
							"<td data-title='归属地'>"+dataStr[i].city+"</td>" +
							"<td data-title='运营商'>"+dataStr[i].carrier+"</td>" +
							"<td data-title='发送内容' id='info_"+i+"' title='"+dataStr[i].sendContent+"'>"+dataStr[i].sendContent+"</td>" +
							"<td data-title='渠道'>"+dataStr[i].cp+"</td>" +
							"<td data-title='通道'>"+dataStr[i].channel+"</td>" +
							"<td data-title='状态'>"+status+"</td>" +
							"<td data-title='同步'>"+isshow+"</td>" +
							"</tr>");

					}

					//动态生成分页页码
					$(".infofoot").append("<tr><td colspan='12' align='center'><ul class='pagination' id='infomsgpage'></ul><ul id='checkinfopagecount'></ul></td></tr>");
					//使用插件分页
					$.jqPaginator('#infomsgpage', {
						totalPages: totalPage,
						visiblePages: pageSize,
						currentPage: pageNum,
						first: '<li class="first"><a href="javascript:void(0);">首页</a></li>',
						prev: '<li class="prev"><a href="javascript:;">上一页</a></li>',
						next: '<li class="next"><a href="javascript:void(0);">下一页</a></li>',
						last: '<li class="last"><a href="javascript:void(0);">尾页</a></li>',
						//page: '<li class="page"><a href="javascript:;">{{page}}</a></li>',
						onPageChange: function (num, type) {
							if (type == "change"){
								checkinfomsg(num);
							}
						}
					});
					$("#checkinfopagecount").append("<li><span>共"+totalPage+"页"+countNum+"条记录</span></li>")

					//处理号码过长展示
					var tr = $(".info_tr");
					for (var i = 0; i < tr.length ; i++) {

						new $.Zebra_Tooltips($("#info_"+i+""));
						var td = $("#info_"+i+"").text();
						if (td.length > 5) {
							//给td设置title属性,并且设置td的完整值.给title属性.
							// $("#content_"+i+"").attr("title",td);
							//获取td的值,进行截取。赋值给text变量保存.
							var text=td.substring(0,5)+"...";
							//重新为td赋值;
							$("#info_"+i+"").text(text);
						}
					}
			}
		});
	}

	function mobilefilter(infoId) {
        var loadingIndex = null;
        $("#mobilefiltercheckinfoId").val(infoId);
        $.ajax({
            type: "POST",
            url: "${basePath}/statistical/mobilefilter",
            data: {"infoId":infoId},
            beforeSend:function () {
                loadingIndex =  layer.msg('查询中...', {time:120000, icon:16, shift:10});
            },
            success:function (result) {
                layer.close(loadingIndex);
                //清空表格数据
                $(".mobilefiltermsg").empty();
                $(".mobilefilterfoot").empty();

                //数据
                var dataStr = result.data;
                console.log(dataStr);
                //动态生成表格数据

                $(".mobilefiltermsg").append("<tr class='info_tr'>" +
                    "<td>"+dataStr.blacklist_count+"</td>" +
                    "<td>"+dataStr.channel_error_count+"</td>" +
                    "<td>"+dataStr.count_limit_count+"</td>" +
                    "<td>"+dataStr.flow_limit_count+"</td>" +
                    "<td>"+dataStr.maskword_count+"</td>" +
                    "<td>"+dataStr.mobile_error_count+"</td>" +
                    "<td>"+dataStr.money_limit_count+"</td>" +
                    "<td>"+dataStr.province_limit_count+"</td>" +
                    "<td>"+dataStr.template_count+"</td>" +
                    "<td>"+dataStr.filter_num+"</td>" +
                    "</tr>");
            }
        });
        //展示号码过滤详情模拟框
        $("#mobilefilterModal").modal();
    }

    function exportmsg(infoId) {
		var loadingIndex = null;
		$.ajax({
			type: "POST",
			url: "${basePath}/statistical/exportmobilemsg",
			data: {"infoId":infoId},
			beforeSend:function () {
				loadingIndex =  layer.msg('导出中...', {time:120000, icon:16, shift:10});
			},
			success:function (result) {
				layer.close(loadingIndex);
				if (result.success){
					//layer.msg("导出成功！", {time:3000, icon:6, shift:2}, function(){});
					window.location.href='${basePath}/down/temp.xls';
				}else{
					layer.msg("导出失败！", {time:2000, icon:5, shift:6}, function(){});
				}
			}
		});
	}
</script>
</body>
</html>

