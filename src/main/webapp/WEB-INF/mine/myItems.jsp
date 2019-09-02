<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>修配连汽配市场</title>
    <link href="${ctx}/css/index.css" rel="stylesheet" type="text/css"/>
    <!--滚动-->
    <script type="text/javascript" src="${ctx}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/js/bxCarousel.js"></script>
    <style>
        .pagebody1 ul li {
            display: inline;
        }
    </style>
    <script type="text/javascript">
        $(function () {
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
            $(".newsfr li").mouseover(function () {
                $(this).addClass("current");
                var href = $(this).find("a").attr("href");
                var title = $(this).find("a").html();
                var pic = $(this).find("input").val();
                var htmls = "";
                htmls += "<a href='" + href + "'><img src='" + pic + "' width='401' height='223' /></a>";
                htmls += "<div class='newsname'><a href='" + href + "'>· " + title + "</a></div>";
                $(".newsfl").html(htmls);
            })

            $(".newsfr li").mouseout(function () {
                $(this).removeClass("current");
            })
        });
    </script>
    <script type="text/javascript">

        function mygoods(id) {
            window.location.href="${ctx}/my/toEditItems?id="+id;
        }

        function deleteById(id) {

            if (!confirm("确定要删除吗?"))
                return;

            //var url = "${ctx}/my/deleteItems?id=" + id +"&url=" + key ;
            $.ajax({
                url: "${ctx}/my/deleteItems",    //请求的url地址
                async: true,//请求是否异步，默认为异步，这也是ajax重要特性
                type: "post",   //请求方式
                data:{"id" : id},
                success: function (data) {
                    window.location.reload();
                }
            });
        }

    </script>
    <script type="text/javascript">
        function history() {
            window.location.href="${ctx}/my/toAddItems";
        }
    </script>
</head>
<body>

<div class="bg_color1">
    <div class="pagebody1">
        <div class="wid">
            <ul class="ht1">
                <li class="big3"><a href="${ctx}/my/myItems">我的货架</a></li>
                <li class="big4"><a href="">我的收藏</a></li>
                <li class="small">共<span>${totalRows}</span>个商品</li>
                <li>
                    <button class="new1" onclick="history();" style="cursor:pointer;">新增货架</button>
                </li>
            </ul>
            <div class="clear"></div>
        </div>
        <div class="wid">
            <div class="pagebody2 mr1 wid"><!--图片滚动1-->
                <div class="wid2">

                        <c:forEach var="sale" items="${page.list}">
                            <ul class="qps">
                            <a href="#" onclick="productgroupedit('${sale.id}');"
                               class="fban">
                                <div class="goods">
                                    <img src="${sale.picUrl}"/>
                                    <div class="goods1">
                                        <p class="p2">
                                        <h3>
                                        <!--
                                            <a class="a2" onclick="deleteById('${sale.id}','${sale.picUrl}')" href="#">&nbsp;&nbsp;&nbsp;&nbsp;</a>
                                            <a class="a1" onclick="mygoods('${sale.id}');" href="#">&nbsp;&nbsp;&nbsp;&nbsp;</a>
                                            -->
                                            <span title="${sale.title}" style="cursor:pointer;">
                                                    ${sale.title} </span>
                                            <img src="${ctx}/images/icon019.png" onclick="mygoods('${sale.id}');"><img src="${ctx}/images/icon015.png" onclick="deleteById('${sale.id}');" >

                                        </h3>
                                        <p>
											<span title="${sale.content}" style="cursor:pointer;">

                                                    ${sale.content} </span>
                                        </p>

                                            <fmt:formatDate value="${sale.updateTime}"
                                                            pattern="yyyy-MM-dd HH:mm:ss"/>
                                        </p>
                                    </div>
                                </div>
                            </a>
                            </ul>
                        </c:forEach>
                        <div class="clear"></div>

                </div>
            </div>
        </div>

        <!--翻页按钮-->
        <ul class="page">


            <c:forEach begin="1" end="${page.pages}" var="pageSize">
                <c:choose>
                    <c:when test="${pageSize==page.pageNum}">
                        <a href="${ctx}/my/myItems?pageNo=${pageSize}&pageSize=8&title=${items.title}&content=${items.content}&brandId=${items.brandId}&partId=${items.partId}" style="background: #C30D23 none repeat scroll 0% 0%;color:#ffffff;">${pageSize}</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${ctx}/my/myItems?pageNo=${pageSize}&pageSize=8&title=${items.title}&content=${items.content}&brandId=${items.brandId}&partId=${items.partId}">${pageSize}</a>
                    </c:otherwise>
                </c:choose>

            </c:forEach>

        </ul>


        <div class="clear"></div>
    </div>
</div>
<div class="bg_color2">
    <div class="footer wid">Copyright © 2014-2024 www.xiupeilian.com All Rights Reserved. 修配连 版权所有</div>
</div>
</body>
</html>
