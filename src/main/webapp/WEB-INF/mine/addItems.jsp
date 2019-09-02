<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
    <title>新增货架</title>
    <meta name="decorator" content="default"/>
    <link href="${ctx}/css/index.css" rel="stylesheet" type="text/css" />
    <script src="${ctx}/js/jquery.min.js" type="text/javascript"></script>
    <script src="${ctx}/js/treeTable/jquery.treeTable.js" type="text/javascript"></script>
    <script src="${ctx}/js/zTree/js/jquery.ztree.core-3.5.js" type="text/javascript"></script>
    <link href="${ctx}/js/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/js/treeTable/themes/vsStyle/treeTable.css" rel="stylesheet" type="text/css"/>
    <%--<style type="text/css">.table td i{margin:0 2px;}</style>--%>
    <SCRIPT type="text/javascript">
        <!--
        var setting = {
            view: {
                dblClickExpand: false,
                selectedMulti:false
            },
            data: {
                simpleData: {
                    enable: true
                }
            },
            callback: {
                //beforeClick: beforeClick,
                onClick: onClick
            }
        };

        var zNodes =[
                <c:forEach items="${brandList}" var="menu">{id:"${menu.id}", pId:"${menu.parentId}", name:"${menu.chineseName}"},
            </c:forEach>
        ]

        function beforeClick(treeId, treeNode) {
            var check = (treeNode && !treeNode.isParent);
            if (!check) alert("");
            return check;
        }

        function onClick(e, treeId, treeNode) {
            var zTree = $.fn.zTree.getZTreeObj("menuTree"),
                    nodes = zTree.getSelectedNodes(),
                    v = "";

             //alert(nodes[0].name+" "+nodes[0].mid);
           var nName=nodes[0].name;
             var nId=nodes[0].id;


            nodes.sort(function compare(a,b){return a.id-b.id;});
            for (var i=0, l=nodes.length; i<l; i++) {
                v += nodes[i].name + ",";
            }
            if (v.length > 0 ) v = v.substring(0, v.length-1);
            //cityObj.attr("value", v);
            ////存品牌名称的输入框
            var parentMenuObj = $("#parentMenuObj");
            // //存品牌id的隐藏域
            var parentIdObj = $("#parentId");

            parentMenuObj.val(nName);
            parentIdObj.val(nId);

            hideMenu();
        }

        function showMenu() {
            var cityObj = $("#parentMenuObj");
            var cityOffset = $("#parentMenuObj").offset();
            $("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");

            $("body").bind("mousedown", onBodyDown);

        }
        function hideMenu() {
            $("#menuContent").fadeOut("fast");
            $("body").unbind("mousedown", onBodyDown);
        }
        function onBodyDown(event) {
            if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
                hideMenu();
            }
        }

        /**
         初始化ztree
         */
        $(document).ready(function(){
            var tree=$.fn.zTree.init($("#menuTree"), setting, zNodes);
            tree.expandAll(true);
            var node = tree.getNodeByParam("id", "${items.brandId}");
            tree.selectNode(node);
            //try{tree.checkNode(node, true, false);}catch(e){}
        });
        //-->
        
         function checkform(){
            brandId=$("#parentMenuObj").val();
            partId=$("#partId").val();
            title=$("#title").val();

            if(brandId.length ==0){
                alert("请选择汽车品牌！");
                return false;
            }
            if(partId.length == 0){
                alert("请选择配件类别！");
                return false;
            }
            if(title.length == 0){
                alert("标题不能为空");
                return false;
            }

            return true;
        }
    </SCRIPT>


    <style type="text/css">
        ul.ztree {margin-top: 10px;border: 1px solid #617775;background: #f0f6e4;width:220px;height:230px;overflow-y:scroll;overflow-x:auto;}
        ul.log {border: 1px solid #617775;background: #f0f6e4;width:300px;height:170px;overflow: hidden;}
        ul.log.small {height:45px;}
        ul.log li {color: #666666;list-style: none;padding-left: 10px;}
        ul.log li.dark {background-color: #E3E3E3;}

        #menuEdit td{
            line-height: 32px;
        }
        
    </style>

</head>
<body >
    
    <body style="background:#efeeec;">
<div class="pagebody6" style="padding:0px;">
        <form action="${ctx}/my/addItems" enctype="multipart/form-data" method="post" onsubmit="return checkform();">
        <h1 style="font-size:30px;"><span style="margin-left:150px">新增商品</span></h1>
        <div class="margin1 padding3"><span>汽车品牌</span>
                <p style="display:inline-block">
                                        <span><input type="text" class="xinzeng" id="parentMenuObj" name="" value="" readonly="true" onclick="showMenu(); return false;"></span>
                                    </p>   <input type="hidden" id="parentId" name="brandId" value="${items.brandId}">
                                    &nbsp;<a id="menuBtn" style="margin-top:4px;" href="#" onclick="showMenu(); return false;">选择</a>
        </div>
        <div class="margin1 padding3"><span>配件类别</span>
                <select class="xinzeng" id="partId" name="partId" onchange="carPartsChange()">
                        <option value="">请选择</option>
                        <c:forEach var="cp" items="${partsList}">
                                <option value="${cp.id}">${cp.name}</option>
                        </c:forEach>
                </select>
        </div>
        <div class="margin1 padding3"><span>商品标题</span>
                <input type="text" id="title" class="xinzeng" name="title" />
        </div>
        <div class="margin1 padding3"><span>图片路径</span>
                <input class="xinzeng" type="file" name="pic" id="button" value="选择上传" />
        </div>
        <div class="margin1 padding3">
                <span class="padding4">货物描述</span>
                <textarea id="content" name="content" class="miaoshu"></textarea>
        </div>
        <input  type="submit" class="tianjia" value="添加到我的货架" />
         <div id="menuContent" class="menuContent" style="display:none; position: absolute;">
                            <ul id="menuTree" class="ztree" style="margin-top:0;"></ul>
                        </div>
        </form>
    </div>
</body>
</body>
</html>
