<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/pages/commons/taglibs.jsp" %>
<%@ include file="/pages/commons/head.jsp" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>修配连汽配市场</title>
<link href="${ctx}/static/parts/css/index.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/static/parts/js/jquery-1.7.1.min.js"></script>
<!--tab切换-->
<script src="${ctx}/static/parts/js/jquery.tabs.js"></script>
<script>
$(function(){
    $("#test  li").click(function(){
      	 $("#test  li").attr("class","");
        $(this).attr("class","active no");
    }); 
});
window.onload=function(){
	setInterval("flushPage()",120000);
};
function flushPage(){
    $.ajax({
        url:"${ctx}/mainAction.do?method=flushCount",    //请求的url地址
        async:true,//请求是否异步，默认为异步，这也是ajax重要特性
        type:"post",   //请求方式
        success:function(data){
        	 document.getElementById("xjd").innerHTML=data;
        },
    });
}

 function Goto(src,menuName){
	 window.top.document.getElementById('body').src =src;
	 if(menuName=='公共货架'){
		 $("#gghj").remove();
	 }
	
}
</script>
</head>
  
  <body>
  <div class="top3"><!--导航-->
        	<div class="wid">
            	<div class="top3_left"><span>修配连</span>汽配市场</div>
                <div class="top3_right"><!--导航-->
          <c:if test="${not empty topMenus}">
             <ul id="test">
	    <c:forEach var="menu" items="${topMenus}" varStatus="status">
	        <c:if test="${not empty menu.name}">
	         
	                <li onclick="javascript:Goto('${ctx}${menu.page}','${menu.name}')"  >
                        	<div class="top"><img src="${ctx}/${menu.image}" /></div>
                            <div class="bottom">${menu.name}</div>
                            <c:if test="${menu.name eq '询价单'}">
                            <div class="radius" style="left:58px" id="xjd">${menu.description}</div>
                            </c:if>
                             <c:if test="${menu.name eq '公共货架'}" >
                            <div id="gghj" style="border-radius: 9px;bottom: 58px;color: #fff;height: 14px; left: 65px;margin: 0 auto;padding: 2px;position: absolute;text-align: center;width: 14px;"><img src="${ctx}/static/parts/images/new.gif"></div>
                            </c:if>
                   </li>
	        </c:if>
	        
	        </c:forEach>
	        
	        </ul>
	        </c:if>
                    <div class="clear"></div>                
                </div>
            </div>
            <div class="clear"></div>
        </div><!--导航-->
  </body>
</html>
