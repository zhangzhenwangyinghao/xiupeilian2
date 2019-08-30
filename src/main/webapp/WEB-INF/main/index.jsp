<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/pages/commons/taglibs.jsp" %>
<%@ include file="/pages/commons/head.jsp" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>修配连汽配市场</title>
<link href="${ctx}/static/parts/css/index.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
        $(function () {
            $('.demo11').Tabs({
                event: 'mouseover'
            });
        });
function dyniframesize(body) {
    var ifm= document.getElementById("body");

    var subWeb = document.frames ? document.frames["body"].document :

ifm.contentDocument;

        if(ifm != null && subWeb != null) {

        ifm.height = subWeb.body.scrollHeight;

        }
}

        	
</script>
</head>

<body id="cont">
	<!--头部-->
		<iframe allowtransparency=true id="top" src="${ctx}/mainAction.do?method=top"  width="100%" height="46px" scrolling="no" frameborder="0"></iframe>
 <!--导航-->
       <iframe allowtransparency=true  id="navigation" src="${ctx}/mainAction.do?method=navigation" width="100%" height="95px" scrolling="no" frameborder="0"></iframe>
		<!--主体-->   <iframe allowtransparency=true id="body"  src="${ctx}/mainAction.do?method=body" width="100%"  frameborder="0" scrolling="auto" name="body" onload="javascript:dyniframesize('body');"></iframe>
    
</body>
</html>