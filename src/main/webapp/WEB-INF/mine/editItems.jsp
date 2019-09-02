<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${ctx}/css/index.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery.min.js"></script>
<script src="${ctx}/js/layer/layer.min1.js" type="text/javascript"></script>

</head>

<body style="background:#efeeec;">
<div class="pagebody6">
        <h3 class="padding1">编辑商品</h3>
        <form action="${ctx}/my/editItems?itemsId=${itemsId}" enctype="multipart/form-data" method="post">
            <input type="hidden" name="id" value="${sale.id}"/>
            <div class="margin1 padding2"><span>标题</span>
                <input type="text" class="xinzeng" name="title" value="${sale.title}"/></div>
            <div class="margin1">
                <span>图片路径</span>
                <input class="sangchuan" type="file" name="pic" id="button" value="选择上传"/>
            </div>
            <div class="margin1 padding3">
                <span class="padding4">货物描述</span>
                <textarea name="content" class="miaoshu">${sale.content}</textarea>
            </div>
            <input  type="submit" class="tianjia" value="保存" />
        </form>
</div>
</body>
</html>