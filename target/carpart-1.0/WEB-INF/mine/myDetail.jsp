<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/pages/commons/taglibs.jsp" %>
<%@ include file="/pages/commons/head.jsp" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style>
a:hover { color: red; }
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>修配连汽配市场</title>
<link href="${ctx}/static/parts/css/index.css" rel="stylesheet" type="text/css" />
<script>
var currentWidth = 0;
var currentHeight = 0;
var originalWidth = 0;
var originalHeight = 0;
function initial(){
    currentWidth = document.getElementById ("myImage").width;
    currentHeight = document.getElementById ("myImage").height;
    originalWidth = currentWidth;
    originalHeight = currentHeight;
    update();
}
function zoomIn(){
    document.getElementById ("myImage").style.width = currentWidth*1.2+"px";
    document.getElementById ("myImage").style.height= currentHeight*1.2+"px";
    update();
   
}
function zoomOut(){
	document.getElementById ("myImage").style.width = currentWidth/1.2+"px";
    document.getElementById ("myImage").style.height = currentHeight/1.2+"px";
    update();
}
function resetImage(){
	document.getElementById ("myImage").style.width = originalWidth+"px";
    document.getElementById ("myImage").style.height = originalHeight+"px";
    update();
}
function update(){
    currentWidth = document.getElementById ("myImage").width;
    currentHeight = document.getElementById ("myImage").height;
} 
</script>
<style type="text/css">
	#suoshu{margin-top:10px;margin-right:30px;font-size: 16px;color:#666666;}
  #suoshu span{font-size:16px;margin-left:-15px;}
	a:hover{color:#C31102;}
  #fb{width:100%;margin-left:-15px;vertical-align:middle;height:38px;line-height:38px;float:left;}
	#fb2{width:100%;vertical-align:middle;height:38px;line-height:38px;}
	#fb1{width:100%;height:38px;line-height:38px;margin-bottom:10px;margin-left:30px;float:left;}
	.fbbut{width:64px;height:32px;background:url(images/butto.png) no-repeat;border:none;border-radius:5px;margin-top:8px;margin-left:55px;color:#fff;}
</style>
</head>

<body class="bg_color3 wid" style="margin-top:-60px;"  onload="initial();">
	<div class="pagebody8">
    
       <div id="fb2">
          <div style="width:70%;float:left;"><strong>${salecommodity.title}</strong>   <c:if test="${salecommodity.delstatus==1}"><span style="color:red">【该商品已经下架】</span></c:if></div> 
       </div> 
     	<c:if test="${not empty  carmodel}">
       <div id="suoshu">所属品牌：${carmodel.name}</div>
       </c:if>
       <c:if test="${not empty  accessoriescategory}">
       <div id="suoshu">配件类别：${accessoriescategory.name}</div>
       </c:if>
        <c:if test="${not empty  prime}">
       <div id="suoshu">精品种类：${prime.name}</div>
       </c:if>
	    <div id="suoshu"><span>商品描述：</span></div>
	  		<textarea cols="50" rows="3" style="resize: none;margin-left:80px;margin-top:-20px;" disabled="disabled">${salecommodity.content}
	  		</textarea>

	  	<div>
		<div id="suoshu">
          <img onclick="zoomIn()" src="${ctx}/static/parts/images/fangda.png"  style="cursor: pointer;"> 
		<img onclick="zoomOut()" src="${ctx}/static/parts/images/suoxiao.png"   style="cursor: pointer;"> 
		<img onclick="resetImage()"  src="${ctx}/static/parts/images/huanyuan.png"  style="cursor: pointer;">
        </div>
        <div>
           <img src="${ctx}${salecommodity.picurl}"  id="myImage"/>
           </div>
       </div>
	  </div>
    <!-- </div> -->
</body>
</html>