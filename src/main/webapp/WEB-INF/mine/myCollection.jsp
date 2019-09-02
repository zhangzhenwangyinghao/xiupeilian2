<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/pages/commons/taglibs.jsp" %>
<%@ include file="/pages/commons/head.jsp" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ taglib prefix="pg"  uri="http://jsptags.com/tags/navigation/pager" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>修配连汽配市场</title>
<link href="${ctx}/static/parts/css/index.css" rel="stylesheet" type="text/css" />
<style>
.pagebody1 ul li{display:inline;} 
</style>
<!--滚动-->
<script type="text/javascript"  src="${ctx}/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/js/bxCarousel.js"></script>
<script type="text/javascript">
            $(function() {
                $('.flexslider').flexslider({
                    directionNav: true,
                    pauseOnAction: false
                });
                $('#demo').bxCarousel({
                    display_num: 4,
                    move: 1,
                    auto: true,
                    speed: 1000
                });
				$(".newsfr li").mouseover(function(){
					$(this).addClass("current");
					var href = $(this).find("a").attr("href");
					var title = $(this).find("a").html();
					var pic = $(this).find("input").val();
					var htmls="";
					htmls+="<a href='"+href+"'><img src='"+pic+"' width='401' height='223' /></a>";
					htmls+="<div class='newsname'><a href='"+href+"'>· "+title+"</a></div>";
					$(".newsfl").html(htmls);
				})
				
				$(".newsfr li").mouseout(function(){
					$(this).removeClass("current");
				})
            });
</script>       
<!--弹出页-->        
<script src="${ctx}/js/layer/layer.min.js" type="text/javascript"></script>
<script type="text/javascript">
function deleteById(id){

    if(!confirm("确定要删除此收藏吗?"))
        return;

    var url = "${ctx}/salecollectionAction.do?method=doDelete&id="+id;
    $.ajax({
        url:url,    //请求的url地址
        async:true,//请求是否异步，默认为异步，这也是ajax重要特性
        type:"post",   //请求方式
        success:function(data){
            window.location.reload();
        }
    });
}
</script>
</head>
<body>
	
     <div class="bg_color1">
    <div class="pagebody1">
    	<div class="wid">
                <ul class="ht1">
                    <li class="big4"><a href="${ctx}/salecommodityAction.do?method=myList">我的货架</a></li>
                    <li class="big3"><a href="${ctx}/salecollectionAction.do?method=myCollection">我的收藏</a></li>
                    <li class="small">共<span>${totalRows}</span>个商品</li>
                </ul>
                <div class="clear"></div>
        </div>
        <div class="wid">  
        <div class="pagebody10"><!--图片滚动1-->
        	<div class="wid2">
                    <ul id="demo">
                        <c:forEach var="sale" items="${salecollectionList_up}" >
                                    <li >
                                <dt   onclick="<c:if test="${not empty sale.picurl}">productgroupedit('${sale.id}');</c:if>"><a href="#"><c:if test="${not empty sale.picurl}"><img src="${ctx}${sale.picurl}"/></c:if>
                                
                                <c:if test="${empty sale.picurl}"><img src="${ctx}/static/parts/images/tu003.png"/></c:if>
                                
                                
                                </a></dt>
                                <c:if test="${not empty sale.title}">
                                    <dd>
                                            <h3>
                                                <a class="a2" onclick="deleteById('${sale.id}')"  href="#">&nbsp;&nbsp;&nbsp;&nbsp;</a>
                                                <c:if test="${sale.delstatus==1}">
                                                <span style="color:red">【该商品已经下架】</span>
                                                </c:if>
                                                <span title="${sale.title}" style="cursor:pointer;">
                                            
                                            <c:set var="title" value="${sale.title}" />
                                            
                                            <c:choose>

													<c:when test="${fn:length(title) > 10}">

														<c:out value="${fn:substring(title, 0, 10)}......" />

													</c:when>

													<c:otherwise>

														<c:out value="${title}" />

													</c:otherwise>
												</c:choose></span></h3>
                                            <p><span title="${sale.content}" style="cursor:pointer;">
                                            
                                            <c:set var="content" value="${sale.content}" />
                                            
                                            <c:choose>

													<c:when test="${fn:length(content) > 10}">

														<c:out value="${fn:substring(content, 0, 10)}......" />

													</c:when>

													<c:otherwise>

														<c:out value="${content}" />

													</c:otherwise>
												</c:choose></span></p>
                                            <p><fmt:formatDate value="${sale.operatetime}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                                    </dd>
                                </c:if>
                            </li>
                        </c:forEach>
                    </ul>
                   <div class="clear"></div>
                    </div>
                </div><!--图片滚动1-->
	<div class="scrollcon mar3"><!--图片滚动2-->
    <div class="wid">
		<div class="LeftBotton" onmousedown="ISL_GoUp()" onmouseup="ISL_StopUp()" onmouseout="ISL_StopUp()"></div>
		<div class="Cont" id="ISL_Cont">
			<div class="ScrCont">
				<div id="List1">
					<!-- 图片列表 begin -->
                    <ul>
                        <c:forEach var="sale" items="${salecollectionList_down}" >
                              <li>
                                <p   class="p1"  onclick="<c:if test="${not empty sale.picurl}">productgroupedit('${sale.id}');</c:if>"><a href="javascript:;"><c:if test="${not empty sale.picurl}"><img src="${ctx}${sale.picurl}"/></c:if></a>
                                 
                                 
                                    <c:if test="${empty sale.picurl}"><img src="${ctx}/static/parts/images/tu003.png"/></c:if>
                                 
                                 </p>
                             			<c:if test="${not empty sale.title}">
                                      <p class="p2">
                                             <span><a class="a2" onclick="deleteById('${sale.id}')"  href="#">&nbsp;&nbsp;&nbsp;&nbsp;</a>
                                            <span title="${sale.title}" style="cursor:pointer;">
                                            
                                            <c:set var="title" value="${sale.title}" />
                                            
                                            <c:choose>

													<c:when test="${fn:length(title) > 10}">

														<c:out value="${fn:substring(title, 0, 10)}......" />

													</c:when>

													<c:otherwise>

														<c:out value="${title}" />

													</c:otherwise>
												</c:choose></span></span>
                                             <i><span title="${sale.content}" style="cursor:pointer;">
                                            
                                            <c:set var="content" value="${sale.content}" />
                                            
                                            <c:choose>

													<c:when test="${fn:length(content) > 10}">

														<c:out value="${fn:substring(content, 0, 10)}......" />

													</c:when>

													<c:otherwise>

														<c:out value="${content}" />

													</c:otherwise>
												</c:choose></span></i>
                                             <b><a><fmt:formatDate value="${sale.operatetime}" pattern="yyyy-MM-dd HH:mm:ss"/></a></b>
                                     </p>
                                	</c:if>
                        </c:forEach>
                    </ul>
                    <div class="clear"></div>
					<!-- 图片列表 end -->
				</div>
				<div id="List2"></div>
			</div>
        </div>
		<div class="RightBotton" onmousedown="ISL_GoDown()" onmouseup="ISL_StopDown()" onmouseout="ISL_StopDown()"></div>
        </div>

            <!--翻页按钮-->
            <ul class="page">
                <pg:pager url="${ctx}/salecollectionAction.do"
                          items="${totalRows}" export="currentPageNumber=pageNumber" maxPageItems="8">
                    <pg:param name="method" value="myCollection" />
                    <pg:pages>
                        <c:choose>
                            <c:when test="${currentPageNumber eq pageNumber }">
                              <a href="#"  style="background: #C30D23 none repeat scroll 0% 0%;color:#ffffff;">${pageNumber }</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageUrl }">${pageNumber }</a>
                            </c:otherwise>
                        </c:choose>
                    </pg:pages>
                </pg:pager>
            </ul>

	</div><!--图片滚动2-->
    </div>
<script>
var Speed = 0.001;//速度(毫秒)
var Space = 1;//每次移动(px)
var PageWidth = 254;//翻页宽度
var fill = 0;//整体移位
var MoveLock = false;
var MoveTimeObj;
var Comp = 0;
var AutoPlayObj = null;
GetObj("List2").innerHTML = GetObj("List1").innerHTML;
GetObj('ISL_Cont').scrollLeft = fill;
GetObj("ISL_Cont").onmouseover = function(){
	clearInterval(AutoPlayObj);
}
GetObj("ISL_Cont").onmouseout = function(){
	AutoPlay();
}

AutoPlay();

function GetObj(objName){
	if(document.getElementById){
		return eval('document.getElementById("'+objName+'")')
	}else{
		return eval('document.all.'+objName)
	}
}

function AutoPlay(){ //自动滚动
	clearInterval(AutoPlayObj);
	AutoPlayObj = setInterval('ISL_GoDown();ISL_StopDown();',6000);//间隔时间
}

function ISL_GoUp(){ //上翻开始
	if(MoveLock) return;
	clearInterval(AutoPlayObj);
	MoveLock = true;
	MoveTimeObj = setInterval('ISL_ScrUp();',Speed);
}

function ISL_StopUp(){ //上翻停止
	clearInterval(MoveTimeObj);
	if(GetObj('ISL_Cont').scrollLeft % PageWidth - fill != 0){
		Comp = fill - (GetObj('ISL_Cont').scrollLeft % PageWidth);
		CompScr();
	}else{
		MoveLock = false;
	}
	AutoPlay();
}

function ISL_ScrUp(){ //上翻动作
	if(GetObj('ISL_Cont').scrollLeft <= 0){
		GetObj('ISL_Cont').scrollLeft = GetObj('ISL_Cont').scrollLeft + GetObj('List1').offsetWidth
	}
		GetObj('ISL_Cont').scrollLeft -= Space ;
}

function ISL_GoDown(){ //下翻
	clearInterval(MoveTimeObj);
	if(MoveLock) return;
	clearInterval(AutoPlayObj);
	MoveLock = true;
	ISL_ScrDown();
	MoveTimeObj = setInterval('ISL_ScrDown()',Speed);
}
function ISL_StopDown(){ //下翻停止
	clearInterval(MoveTimeObj);
	if(GetObj('ISL_Cont').scrollLeft % PageWidth - fill != 0 ){
		Comp = PageWidth - GetObj('ISL_Cont').scrollLeft % PageWidth + fill;
		CompScr();
	}else{
		MoveLock = false;
	}
	AutoPlay();
}

function ISL_ScrDown(){ //下翻动作
	if(GetObj('ISL_Cont').scrollLeft >= GetObj('List1').scrollWidth){
		GetObj('ISL_Cont').scrollLeft = GetObj('ISL_Cont').scrollLeft - GetObj('List1').scrollWidth;
	}
	GetObj('ISL_Cont').scrollLeft += Space ;
}

function CompScr(){
	var num;
	if(Comp == 0){
		MoveLock = false;return;
	}
	if(Comp < 0){ //上翻
		if(Comp < -Space){
			Comp += Space;
			num = Space;
		}else{
			num = -Comp;
			Comp = 0;
		}
		GetObj('ISL_Cont').scrollLeft -= num;
		setTimeout('CompScr()',Speed);
	}else{ //下翻
		if(Comp > Space){
			Comp -= Space;
			num = Space;
		}else{
			num = Comp;
			Comp = 0;
		}
		GetObj('ISL_Cont').scrollLeft += num;
		setTimeout('CompScr()',Speed);
	}
}

    
	function productgroupedit(id) {
			$.jBox("iframe:${ctx}/salecommodityAction.do?method=toArticle&id="+id, {
			title : "",
			width : 1020,
			height : 700,
			buttons : { /*'关闭': true*/}
		});
	} 
</script>
        <div class="clear"></div>
    </div>
    </div>
    <div class="bg_color2">
    	<div class="footer wid">Copyright © 2014-2024 www.xiupeilian.com  All Rights Reserved. 修配连 版权所有</div>
    </div>
</body>
</html>
