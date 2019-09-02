<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>新增货架</title>
    <meta name="decorator" content="default"/>
    <link href="${ctx}/static/parts/css/index.css" rel="stylesheet" type="text/css" />
    <script src="${ctx}/static/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>

</head>
<body >
    
    <body style="background:#efeeec;">
<div class="pagebody6" style="padding:0px;">
        <form action="${ctx}/primeImgUpload" enctype="multipart/form-data" method="post" onsubmit="return checkform();">
        <h1 style="font-size:30px;"><span style="margin-left:150px">新增商品</span></h1>
        <div class="margin1 padding3"><span>精品类别</span>
                <select class="xinzeng" id="partId" name="carpartsId" onchange="carPartsChange()">
                        <option value="">请选择</option>
                        <c:forEach var="cp" items="${primeList}">
                                <option value="${cp.id}">${cp.name}</option>
                        </c:forEach>
                </select>
        </div>
        <div class="margin1 padding3"><span>商品标题</span>
                <input type="text" id="title" class="xinzeng" name="title" />
        </div>
        <div class="margin1 padding3"><span>图片路径</span>
                <input class="xinzeng" type="file" name="file" id="button" value="选择上传" />
        </div>
        <div class="margin1 padding3">
                <span class="padding4">货物描述</span>
                <textarea id="content" name="content" class="miaoshu"></textarea>
        </div>
        <input  type="submit" class="tianjia" value="添加到我的货架" />
    </div>
</body>
</body>
</html>
