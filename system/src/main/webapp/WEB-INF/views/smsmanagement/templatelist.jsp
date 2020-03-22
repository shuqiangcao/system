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
	<!-- Custom styles for this template -->
	<link href="${basePath}/assets/css/style.css" rel="stylesheet">
	<link href="${basePath}/assets/css/style-responsive.css" rel="stylesheet">
	<script src="${basePath}/assets/js/jquery.js"></script>
	<script src="${basePath}/assets/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="${basePath}/bootstrap/css/zebra_tooltips.css">
	<link rel="stylesheet" href="${basePath}/bootstrap/css/ySelect.css">
	<script src="${basePath}/bootstrap/js/zebra_tooltips.min.js"></script>
	<script src="${basePath}/bootstrap/js/ySelect.js"></script>
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
			<h3><i class="fa fa-angle-right"></i>短信管理/短信模板</h3>
			<div class="row mt">
				<div>
					<h4><i class="fa fa-angle-right"></i>模板列表</h4>
					<section id="unseen">
						<button type="button" class="btn btn-primary" style="float:left;" onclick="addtemplate();"><i class="glyphicon glyphicon-plus"></i> 新增</button>
						<br>
						<br>
						<br>
						<div class="table-responsive">
							<table class="table  table-bordered">
								<thead>
								<tr>
									<th>#</th>
									<th><input type="checkbox"></th>
									<th>ID</th>
									<th>模板id</th>
									<th>模板类型</th>
									<th>模板名称</th>
									<th width="10px">模板内容</th>
									<th>通道</th>
									<th>渠道</th>
									<th>描述</th>
									<th>运营商|价格</th>
									<th>是否审核</th>
									<th>支持变量</th>
									<th>创建时间</th>
									<th colspan="2" align="center">操作</th>
								</tr>
								</thead>
								<tbody>
								<c:forEach items="${result.data}" var="item" varStatus="status">
									<tr class="content_tr">
										<td>${status.index+1}</td>
										<td><input type="checkbox"></td>
										<td>${item.id}</td>
										<td>${item.templateId}</td>
										<td>${item.type}</td>
										<td>${item.templateName}</td>
											<%--<td id="content_${status.index}" onmouseover="overShow('${item.sendContent}');" onmouseout="outHide();">${item.sendContent}</td>--%>
										<td id="content_${status.index}" class="sendcontent" title="${item.sendContent}">${item.sendContent}</td>
										<td>${item.channel}</td>
										<td>${item.cp}</td>
										<td>${item.describe}</td>
										<td>${item.price}</td>
										<td>
											<c:if test="${item.isAudit.equals('0')}">
												是
											</c:if>
											<c:if test="${item.isAudit.equals('1')}">
												否
											</c:if>
										</td>
										<td>
											<c:if test="${item.isVariable.equals('0')}">
												否
											</c:if>
											<c:if test="${item.isVariable.equals('1')}">
												是
											</c:if>
										</td>
										<td><fmt:formatDate value="${item.operateTime}" type="both"/></td>
										<td>
											<button type="button" class="btn btn-primary btn-xs" onclick="edittemplate(${item.id});" data-toggle="modal" data-target="#edittemplateModal"><i class=" glyphicon glyphicon-pencil">编辑</i></button>
										</td>
										<td>
											<button type="button" class="btn btn-danger btn-xs" onclick="deletetemplate(${item.id});"><i class=" glyphicon glyphicon-remove">删除</i></button>
										</td>
									</tr>
								</c:forEach>
								</tbody>
								<script>
									//处理表格内容过长问题
									$(document).ready(function(){
										var tr = $(".content_tr");
										for (var i = 0; i < tr.length ; i++) {

											new $.Zebra_Tooltips($("#content_"+i+""));
											var td = $("#content_"+i+"").text();
											if (td.length > 5) {
												//给td设置title属性,并且设置td的完整值.给title属性.
												// $("#content_"+i+"").attr("title",td);
												//获取td的值,进行截取。赋值给text变量保存.
												var text=td.substring(0,5)+"...";
												//重新为td赋值;
												$("#content_"+i+"").text(text);
											}
										}
									});
								</script>
								<tfoot>
								<tr >
									<td colspan="16" align="center">
										<ul class="pagination">
											<ul class="pagination" id="templatecountpage">
												<input type="hidden" value="${result.totalPage}" id="totalpage">
												<input type="hidden" value="${result.pageNum}" id="pagenum">
												<input type="hidden" value="${result.pageSize}" id="pagesize">
												<input type="hidden" value="${result.countNum}" id="countnum">
											</ul>
											<ul id="templatecountpagecount">
											</ul>
										</ul>
									</td>
								</tr>
								</tfoot>
							</table>
						</div>
					</section>
				</div><!-- /col-lg-9 END SECTION MIDDLE -->

				<!-- **********************************************************************************************************************************************************
                RIGHT SIDEBAR CONTENT
                *********************************************************************************************************************************************************** -->
			</div><! --/row -->
		</section>
	</section>
	<!--main content end-->
</section>
<script class="include" type="text/javascript" src="${basePath}/assets/js/jquery.dcjqaccordion.2.7.js"></script>
<script src="${basePath}/assets/js/jquery.scrollTo.min.js"></script>
<script src="${basePath}/assets/js/jquery.nicescroll.js" type="text/javascript"></script>
<!--common script for all pages-->
<script src="${basePath}/assets/js/common-scripts.js"></script>
<script src="${basePath}/layer/layer.js"></script>
<script>
	//使用插件分页
	var pagesum = $("#totalpage").val();
	var pageindex = $("#pagenum").val();
	var pagesize = $("#pagesize").val();
	var countnum = $("#countnum").val();
	if (pagesum == 0 && countnum == 0){
		pagesum = 1;
	}
	$.jqPaginator('#templatecountpage', {
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
	$("#templatecountpagecount").append("<li><span>共"+pagesum+"页"+countnum+"条记录</span></li>")
</script>

<%--新增页面--%>
<form id="templateform" action="${basePath}/template/savetemplate" method="post">
	<%--data-backdrop="static"  禁止点击空白处关闭弹窗--%>
	<div class="modal fade" id="addtemplateModal" tabindex="-1" role="dialog" aria-labelledby="addmyModalLabel" data-backdrop="static">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="addmyModalLabel">新增模板</h4>
				</div>
				<div class="modal-body">

					<div class="form-group">
						<label for="templateid">模板id</label>
						<input type="text" name="templateid" class="form-control" id="templateid" placeholder="模板id">
					</div>
					<div class="form-group" id="addtype">
						<label>模板类型</label>
						<br>
						<input tabindex="19" type="radio" id="line-radio-1" name="addline-radio" value="验证码">
						<label for="line-radio-1">验证码</label>&nbsp&nbsp&nbsp&nbsp
						<input tabindex="20" type="radio" id="line-radio-2" name="addline-radio" value="通知&订单">
						<label for="line-radio-2">通知&订单</label>&nbsp&nbsp&nbsp&nbsp
						<input tabindex="20" type="radio" id="line-radio-3" name="addline-radio" value="营销">
						<label for="line-radio-3">营销</label>&nbsp&nbsp&nbsp&nbsp
						<input tabindex="20" type="radio" id="line-radio-4" name="addline-radio" value="紧急报警">
						<label for="line-radio-4">紧急报警</label>
					</div>
					<div class="form-group">
						<label for="templatename">模板名称</label>
						<input type="text" name="templatename" class="form-control" id="templatename" placeholder="模板名称">
					</div>
					<div class="form-group">
						<label for="templateContent">模板内容</label>
						<textarea name="templateContent" class="form-control" id="templateContent" placeholder="模板内容" onchange="sumlength();"></textarea>
						<div style="color: #FF6600" id="contentlength"></div>
					</div>
					<div class="form-group">
						<label for="channel">通道</label>
						<div id="channel">
							<select id='m1' class="channeloption" multiple="multiple">
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="tempcp">渠道</label>
						<div id="tempcp">
							<select class="form-control" id='addtempcp' style="width: 100%">
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="price1">价格</label>
						<input type="text" name="price" class="form-control" id="price1" placeholder="价格">
					</div>
					<div class="form-group">
						<label for="describe">描述</label>
						<input type="text" name="describe" class="form-control" id="describe" placeholder="描述">
					</div>
					<div class="form-group" id="audit">
						<label>是否审核</label>
						<br>
						<input tabindex="19" type="radio" id="auditline-radio-1" name="auditline-radio" value="0">
						<label for="auditline-radio-1">是</label>&nbsp&nbsp&nbsp&nbsp
						<input tabindex="20" type="radio" id="auditline-radio-2" name="auditline-radio" value="1">
						<label for="auditline-radio-2">否</label>&nbsp&nbsp&nbsp&nbsp
					</div>
					<div class="form-group" id="templatevariable">
						<label>支持变量</label>
						<br>
						<input tabindex="19" type="radio" id="templatevariableline-radio-1" name="templatevariableline-radio" value="1">
						<label for="templatevariableline-radio-1">是</label>&nbsp&nbsp&nbsp&nbsp
						<input tabindex="20" type="radio" id="templatevariableline-radio-2" name="templatevariableline-radio" value="0">
						<label for="templatevariableline-radio-2">否</label>&nbsp&nbsp&nbsp&nbsp
					</div>
				</div>
				<div class="modal-footer">
					<%--data-dismiss="modal"  让按钮有关闭弹窗的作用--%>
					<button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
					<button type="button" id="btn_submit" class="btn btn-primary" onclick="savetemplate();"><span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>保存</button>
					<button type="reset" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i>重置</button>
				</div>
			</div>
		</div>
	</div>
</form>
<script>
	$(function () {
		$('.channeloption').ySelect();

		// $("input[name='auditline-radio']").iCheck({
		// 	checkboxClass: 'icheckbox_flat-red',
		// 	radioClass: 'iradio_flat-red',
		// 	increaseArea: '20%',
		// 	labelHover: true,
		// });
		//
		// $("input[name='addline-radio']").iCheck({
		// 	checkboxClass: 'icheckbox_flat-red',
		// 	radioClass: 'iradio_flat-red',
		// 	increaseArea: '20%',
		// 	labelHover: true,
		// });
	});

	function sumlength(){
		var tempContent = $("#templateContent").val();
		var num = 0;
		var smssum = 0;
		for (i = 0; i < tempContent.length; i++) {
			leng = tempContent.charCodeAt(i);
			if (leng > 255) {
				count = 2;
			} else {
				count = 1;
			}
			num += count;
		}
		if (num > 140 ) {
			if (num % 140 == 0) {
				smssum = num / 140;
			}else {
				smssum = parseInt(num / 140 +1);
			}
		}else{
			smssum = 1;
		}
		$("#contentlength").html("已输入"+tempContent.length+"个字符,按照"+smssum+"条短信计费");
	}

</script>
<script>
	//监听关闭弹窗事件，关闭之后清除弹窗数据
	// $('#addtemplateModal').on('hidden.bs.modal', function (){
	//     alert("关闭")
	//     $("input[name='line-radio']").iCheck('uncheck');
	//     document.getElementById("templateform").reset();
	// });

	function savetemplate() {
		var templateid = $("#templateid").val();
		var type = $("input[name='addline-radio']:checked").val();
		var templatename = $("#templatename").val();
		var templateContent = $("#templateContent").val();
		var price = $("#price1").val();
		var describe = $("#describe").val();
		var channel = $("#m1").ySelectedTexts(",");
		var cp = $("#addtempcp").val();
		var audit = $("input[name='auditline-radio']:checked").val();
		var templatevariable = $("input[name='templatevariableline-radio']:checked").val();
		if(templateid == ""){
			layer.msg("模板id不能为空，请输入模板id", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		if(type == ""){
			layer.msg("模板类型不能为空，请选择模板类型", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		if(templatename == ""){
			layer.msg("模板名称不能为空，请输入模板名称", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		if(templateContent == ""){
			layer.msg("模板内容不能为空，请输入模板内容", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		if(price == ""){
			layer.msg("价格不能为空，请输入价格", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		if(channel == ""){
			layer.msg("通道不能为空，请选择通道", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		if(cp == ""){
			layer.msg("渠道不能为空，请选择渠道", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		if(audit == ""){
			layer.msg("是否审核不能为空，请选择是否审核", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		if(templatevariable == ""){
			layer.msg("模板是否支持变量不能为空，请选择是否支持变量", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		//数据校验通过后关闭弹窗
		$("#addtemplateModal").modal("hide");

		var loadingIndex = null;
		$.ajax({
			type:"POST",
			url:"${basePath}/template/savetemplate",
			data:JSON.stringify({"templateId":templateid,"type":type,"templateName":templatename,"sendContent":templateContent,"price":price,"describe":describe,"channel":channel,"isAudit":audit,"cp":cp,"isVariable":templatevariable}),
			contentType:"application/json;charset=UTF-8",
			beforeSend:function () {
				loadingIndex =  layer.msg('处理中...', {time:600000, icon:16, shift:10});
			},
			success:function (result) {
				layer.close(loadingIndex);
				if (result.success){
					layer.close(loadingIndex);
					layer.msg("新增签名成功！", {time:3000, icon:6, shift:2}, function(){});
					window.setTimeout("window.location.href='${basePath}/template/templatelist'",2000);
				}else{
					layer.msg("新增签名失败！", {time:2000, icon:5, shift:6}, function(){});
				}
			}
		});
	}
</script>
<%--编辑页面--%>
<div>
	<form id="edittemplateform" action="${basePath}/template/saveedittemplate" method="post">
		<input type="hidden" id="updateid">
		<%--data-backdrop="static"  禁止点击空白处关闭弹窗--%>
		<div class="modal fade" id="edittemplateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title" id="myModalLabel">编辑模板</h4>
					</div>
					<div class="modal-body">

						<div class="form-group">
							<label for="edittemplateid">模板id</label>
							<input type="text" name="edittemplateid" class="form-control" id="edittemplateid" placeholder="模板id">
						</div>
						<div class="form-group" id="edittype">
							<label>模板类型</label>
							<br>
							<input tabindex="19" type="radio" id="editline-radio-1" name="editline-radio" value="验证码">
							<label for="editline-radio-1">验证码</label>&nbsp&nbsp&nbsp&nbsp
							<input tabindex="20" type="radio" id="editline-radio-2" name="editline-radio" value="通知&订单">
							<label for="editline-radio-2">通知&订单</label>&nbsp&nbsp&nbsp&nbsp
							<input tabindex="20" type="radio" id="editline-radio-3" name="editline-radio" value="营销">
							<label for="editline-radio-3">营销</label>&nbsp&nbsp&nbsp&nbsp
							<input tabindex="20" type="radio" id="editline-radio-4" name="editline-radio" value="紧急报警">
							<label for="editline-radio-4">紧急报警</label>
						</div>
						<div class="form-group">
							<label for="edittemplatename">模板名称</label>
							<input type="text" name="edittemplatename" class="form-control" id="edittemplatename" placeholder="模板名称">
						</div>
						<div class="form-group">
							<label for="edittemplateContent">模板内容</label>
							<textarea name="edittemplateContent" class="form-control" id="edittemplateContent" placeholder="模板内容" onchange="editsumlength();"></textarea>
							<div style="color: #FF6600" id="editcontentlength"></div>
						</div>
						<div class="form-group">
							<label for="editchannel">通道</label>
							<div id="editchannel">
								<select id='m2' class="editchanneloption" multiple="multiple">
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="edittempcp">渠道</label>
							<div id="edittempcp">
								<select class="form-control" id='edittemplatecp' style="width: 100%">
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="editprice1">价格</label>
							<input type="text" name="editprice" class="form-control" id="editprice1" placeholder="价格">
						</div>
						<div class="form-group">
							<label for="editdescribe">描述</label>
							<input type="text" name="editdescribe" class="form-control" id="editdescribe" placeholder="描述">
						</div>
						<div class="form-group" id="editaudit">
							<label>是否审核</label>
							<br>
							<input tabindex="19" type="radio" id="editauditline-radio-1" name="editauditline-radio" value="0">
							<label for="editauditline-radio-1">是</label>&nbsp&nbsp&nbsp&nbsp
							<input tabindex="20" type="radio" id="editauditline-radio-2" name="editauditline-radio" value="1">
							<label for="editauditline-radio-2">否</label>&nbsp&nbsp&nbsp&nbsp
						</div>
						<div class="form-group" id="edittemplatevariable">
							<label>支持变量</label>
							<br>
							<input tabindex="19" type="radio" id="edittemplatevariableline-radio-1" name="edittemplatevariableline-radio" value="1">
							<label for="edittemplatevariableline-radio-1">是</label>&nbsp&nbsp&nbsp&nbsp
							<input tabindex="20" type="radio" id="edittemplatevariableline-radio-2" name="edittemplatevariableline-radio" value="0">
							<label for="edittemplatevariableline-radio-2">否</label>&nbsp&nbsp&nbsp&nbsp
						</div>
					</div>
					<div class="modal-footer">
						<%--data-dismiss="modal"  让按钮有关闭弹窗的作用--%>
						<button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
						<button type="button" id="btn_submit" class="btn btn-primary" onclick="saveedittemplate(${item.id});"><span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>保存</button>
						<button type="reset" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i>重置</button>
					</div>
				</div>
			</div>
		</div>
	</form>
	<script>

		function editsumlength(){
			var tempContent = $("#edittemplateContent").val();
			var num = 0;
			var smssum = 0;
			for (i = 0; i < tempContent.length; i++) {
				leng = tempContent.charCodeAt(i);
				if (leng > 255) {
					count = 2;
				} else {
					count = 1;
				}
				num += count;
			}
			if (num > 140 ) {
				if (num % 140 == 0) {
					smssum = num / 140;
				}else {
					smssum = parseInt(num / 140 +1);
				}
			}else{
				smssum = 1;
			}
			$("#editcontentlength").html("已输入"+tempContent.length+"个字符,按照"+smssum+"条短信计费");
		}


		//监听编辑模板模拟框关闭弹窗事件，关闭之后清除弹窗数据
		$('#edittemplateModal').on('hidden.bs.modal', function (){
			//清除选中的模板类型(icheck插件)
			// $("input[name='editline-radio']").iCheck('uncheck');
			// $("input[name='editauditline-radio']").iCheck('uncheck');
			//清除表单数据
			document.getElementById("edittemplateform").reset();
		});

		//初始化通道下拉复选框(第三方插件)
		$(function () {
			$('.editchanneloption').ySelect();
		});
		//icheck样式
		// $("input[name='editline-radio']").iCheck({
		// 	checkboxClass: 'icheckbox_flat-red',
		// 	radioClass: 'iradio_flat-red',
		// 	labelHover: true,
		// });
		// $("input[name='editauditline-radio']").iCheck({
		// 	checkboxClass: 'icheckbox_flat-red',
		// 	radioClass: 'iradio_flat-red',
		// 	labelHover: true,
		// });
	</script>
</div>
</body>
<script type="text/javascript">
	//监听新增模板模拟框关闭弹窗事件，关闭之后清除弹窗数据
	$('#addtemplateModal').on('hidden.bs.modal', function (){
		//请求模板内容提示消息
		$("#contentlength").html("");
		// //清除选中的模板类型
		// $("#addtype").find("[type='radio']").iCheck('uncheck');
		// //清除选中的是否审核
		// $("input[name='auditline-radio']").iCheck('uncheck');
		document.getElementById("templateform").reset();
	});

	function deletetemplate(templateId) {
		layer.confirm("是否确定删除模板信息?",{icon: 3,title:'提示'},function(cindex){
			$.ajax({
				type:"GET",
				url:"${basePath}/template/deletetemplate",
				data:{"templateId":templateId},
				success:function (result) {
					if (result.success){
						layer.msg("删除签名成功！", {time:3000, icon:6, shift:2}, function(){});
						window.setTimeout("window.location.href='${basePath}/template/templatelist'",2000);
					}else{
						layer.msg("删除签名失败！", {time:3000, icon:6, shift:2}, function(){});
					}
				}
			});
			layer.close(cindex);
		},function (cindex) {
			layer.close(cindex);
		});

	}
	//翻页
	function changePageNum(pageNum){
		window.location.href = "${basePath}/template/templatelist?pageNum="+pageNum;
	}
	//弹出新增页面
	function addtemplate() {
		//查询通道
		$.ajax({
			type:"GET",
			url:"${basePath}/template/checkchannel",
			data:{},
			dataType:"json",
			success:function(result){
				console.log(result.data);
				var channelStr = result.data;
				var option = $("#m1").find("option");
				console.log(option.length);
				if(option.length > 0){
					option.remove();
					option = $("#m1");
				}else{
					option = $("#m1");
				}
				for (var i = 0; i < channelStr.length; i++) {
					var account = "";
					var price = "";
					$.each(channelStr[i], function(item) {
						if(item == "account"){
							account = channelStr[i][item];//key所对应的value
						}
						if (item == "price") {
							price = channelStr[i][item];//key所对应的value
						}
					});
					option.append('<option value="' + account + '">'+account+'('+price+')</option>');
				}
				console.log(option);
				$(option).ySelect();
			}
		});

		//查询渠道
		$.ajax({
			type:"GET",
			url:"${basePath}/template/checkcp",
			data:{},
			dataType:"json",
			success:function(result){
				//console.log(result.data);
				var cpStr = result.data;
				var option = $("#addtempcp").find("option");
				//console.log(option.length);
				if(option.length > 0){
					option.remove();
					option = $("#addtempcp");
				}else{
					option = $("#addtempcp");
				}
				option.append('<option value="">请选择渠道</option>');
				for (var i = 0; i < cpStr.length; i++) {
					var account = "";
					$.each(cpStr[i], function(item) {
						if(item == "account"){
							account = cpStr[i][item];//key所对应的value
						}
					});
					option.append('<option value="' + account + '">'+account+'</option>');
				}
				//console.log(option);
			}
		});

		$('.channeloption').ySelect();
		//id:myModal 在addtemplate.jsp页面
		$("#addtemplateModal").modal();
	}


	//弹出编辑页面，回显数据
	var loadingIndex = null;
	function edittemplate(templateId) {
		//查询通道
		$.ajax({
			type:"GET",
			url:"${basePath}/template/checkchannel",
			data:{},
			dataType:"json",
			success:function(result){
				//console.log(result.data);
				var option = $("#m2").find("option");
				var channelStr = result.data;
				if(option.length > 0){
					console.log("长度===》"+option.length);
					option.remove();
					option = $("#m2");
				}else{
					console.log("长度===》"+option.length);
					option = $("#m2");
				}
				for (var i = 0; i < channelStr.length; i++) {
					var account = "";
					var price = "";
					$.each(channelStr[i], function(item) {
						if(item == "account"){
							account = channelStr[i][item];//key所对应的value
						}
						if (item == "price") {
							price = channelStr[i][item];//key所对应的value
						}
					});
					option.append('<option id="'+i+'" value="' + account + '">'+account+'('+price+')</option>');
				}
				//console.log(option);
				//$(option).ySelect();
				$('.editchanneloption').ySelect();

				//查询渠道
				$.ajax({
					type:"GET",
					url:"${basePath}/template/checkcp",
					data:{},
					dataType:"json",
					success:function(result){
						console.log(result.data);
						var cpStr = result.data;
						var option = $("#edittemplatecp").find("option");
						console.log(option.length);
						if(option.length > 0){
							option.remove();
							option = $("#edittemplatecp");
						}else{
							option = $("#edittemplatecp");
						}
						option.append('<option id="cp_0" value="">请选择渠道</option>');
						for (var i = 0; i < cpStr.length; i++) {
							var account = "";
							$.each(cpStr[i], function(item) {
								if(item == "account"){
									account = cpStr[i][item];//key所对应的value
								}
							});
							option.append('<option id="cp_'+(parseInt(i)+1)+'" value="' + account + '">'+account+'</option>');
						}
						console.log(option);

						//查询需要编辑的数据
						$.ajax({
							type:"GET",
							url:"${basePath}/template/edittemplate",
							data:{"templateId":templateId},
							dataType:"json",
							beforeSend:function () {
								loadingIndex =  layer.msg('处理中...', {icon: 16});
							},
							success:function (result) {
								layer.close(loadingIndex);
								if (result.success){
									//JSON.parse()里的参数只能是string类型,返回的本就是json不用在转化
									var dataStr = result.data;
									$("#edittemplateid").attr("value",dataStr.templateId);
									var list = $("input[name='editline-radio']");
									for (var i = 1; i <= list.length ; i++) {
										var value = $("#editline-radio-"+i+"").val();
										if (dataStr.type == value){
											$("#editline-radio-"+i+"").prop("checked",true);
										}
									}
									var variablelist = $("input[name='edittemplatevariableline-radio']");
									for (var i = 1; i <= variablelist.length ; i++) {
										var value = $("#edittemplatevariableline-radio-"+i+"").val();
										if (dataStr.isVariable == value){
											$("#edittemplatevariableline-radio-"+i+"").prop("checked",true);
										}
									}
									$("#updateid").attr("value",dataStr.id); //更新的id
									$("#edittemplatename").attr("value",dataStr.templateName);
									$("#edittemplateContent").val(dataStr.sendContent);
									$("#editprice1").attr("value",dataStr.price);
									$("#editdescribe").attr("value",dataStr.describe);
									var op = $("#m2").find("option");
									for (var i = 0; i < op.length; i++) {
										var opvalue = $("#"+i+"").val();
										var str = dataStr.channel;
										console.log(opvalue);
										//模板通道是否包含选项的通道，设置选中
										if (str.indexOf(opvalue) != -1){
											$("#"+i+"").attr("selected",true);
										}
									}
									var cpop = $("#edittemplatecp").find("option");
									for (var i = 0; i < cpop.length; i++) {
										var opvalue = $("#cp_"+i+"").val();
										console.log(opvalue);
										var str = dataStr.cp;
										//模板渠道是否包含选项的渠道，设置选中
										if (opvalue && str.indexOf(opvalue) != -1){
											console.log("渠道设置选中");
											$("#cp_"+i+"").attr("selected",true);
										}
									}
									//通道复选框修改后重新加载，因为ySelect插件暂时不支持动态渲染数据
									$(".editchanneloption").ySelect();

									var list = $("input[name='editauditline-radio']");
									for (var i = 1; i <= list.length ; i++) {
										var value = $("#editauditline-radio-"+i+"").val();
										if (dataStr.isAudit == value){
											$("#editauditline-radio-"+i+"").prop("checked",true);
										}
									}

									var editnum = 0;
									var editsmssum = 0;
									for (i = 0; i < dataStr.sendContent.length; i++) {
										leng = dataStr.sendContent.charCodeAt(i);
										if (leng > 255) {
											count = 2;
										} else {
											count = 1;
										}
										editnum += count;
									}
									if (editnum > 140 ) {
										if (editnum % 140 == 0) {
											editsmssum = editnum / 140;
										}else {
											editsmssum = parseInt(editnum / 140 +1);
										}
									}else{
										editsmssum = 1;
									}
									$("#editcontentlength").html("已输入"+dataStr.sendContent.length+"个字符,按照"+editsmssum+"条短信计费");
								}
							}
						});
					}
				});
			}
		});

	}

	//保存修改
	function saveedittemplate() {
		var updatetempid = $("#updateid").val();
		var edittemplateid = $("#edittemplateid").val();
		var edittype = $("input[name='editline-radio']:checked").val();
		var edittemplatename = $("#edittemplatename").val();
		var edittemplateContent = $("#edittemplateContent").val();
		var editprice1 = $("#editprice1").val();
		var editdescribe = $("#editdescribe").val();
		var editchannel = $("#m2").ySelectedTexts(",");
		var editcp = $("#edittemplatecp").val();
		var editaudit = $("input[name='editauditline-radio']:checked").val();
		var edittemplatevariable = $("input[name='edittemplatevariableline-radio']:checked").val();

		if(edittemplateid == ""){
			layer.msg("模板id不能为空，请输入模板id", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		if(edittype == ""){
			layer.msg("模板类型不能为空，请选择模板类型", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		if(edittemplatename == ""){
			layer.msg("模板名称不能为空，请输入模板名称", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		if(edittemplateContent == ""){
			layer.msg("模板内容不能为空，请输入模板内容", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		if(editprice1 == ""){
			layer.msg("价格不能为空，请输入价格", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		if(editchannel == ""){
			layer.msg("通道不能为空，请选择通道", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		if(editcp == ""){
			layer.msg("渠道不能为空，请选择渠道", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		if(editaudit == ""){
			layer.msg("是否审核不能为空，请选择是否审核", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		if(edittemplatevariable == ""){
			layer.msg("是否支持变量不能为空，请选择是否支持变量", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		//数据校验通过后关闭弹窗
		$("#addtemplateModal").modal("hide");

		var loadingIndex = null;
		$.ajax({
			type:"POST",
			url:"${basePath}/template/saveedittemplate",
			data:JSON.stringify({"id":updatetempid,"templateId":edittemplateid,"type":edittype,"templateName":edittemplatename,"sendContent":edittemplateContent,"price":editprice1,"describe":editdescribe,"channel":editchannel,"cp":editcp,"isAudit":editaudit,"isVariable":edittemplatevariable}),
			contentType:"application/json;charset=UTF-8",
			beforeSend:function () {
				loadingIndex =  layer.msg('处理中...', {icon: 16});
			},
			success:function (result) {
				layer.close(loadingIndex);
				if (result.success){
					layer.close(loadingIndex);
					layer.msg("编辑签名成功！", {time:3000, icon:6, shift:2}, function(){});
					window.setTimeout("window.location.href='${basePath}/template/templatelist'",2000);
				}else{
					layer.msg("编辑签名失败！", {time:2000, icon:5, shift:6}, function(){});
				}
			}
		});
	}
</script>
</html>

