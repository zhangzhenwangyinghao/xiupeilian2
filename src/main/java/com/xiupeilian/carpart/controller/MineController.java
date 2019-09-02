package com.xiupeilian.carpart.controller;

import com.aliyun.oss.OSSClient;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiupeilian.carpart.constant.SysConstant;
import com.xiupeilian.carpart.model.Brand;
import com.xiupeilian.carpart.model.Items;
import com.xiupeilian.carpart.model.Parts;
import com.xiupeilian.carpart.model.SysUser;
import com.xiupeilian.carpart.service.BrandService;
import com.xiupeilian.carpart.service.ItemsService;
import com.xiupeilian.carpart.util.AliyunOSSClientUtil;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * @Description:
 * @Author: Tu Xu
 * @CreateDate: 2019/8/30 9:20
 * @Version: 1.0
 **/
@Controller
@RequestMapping("/my")
public class MineController {
    @Autowired
    private ItemsService itemsService;
    @Autowired
    private BrandService brandService;

    @RequestMapping("/myItems")
    public String toMine(Items items, Integer pageSize, Integer pageNo, HttpServletRequest request){
        //第一次需要初始化分页条件
        pageSize=pageSize==null?8:pageSize;
        pageNo=pageNo==null?1:pageNo;
        //开始分页查询
        PageHelper.startPage(pageNo,pageSize);
        //从session中得到用户信息
        SysUser user =  (SysUser) request.getSession().getAttribute("user");
        //根据用户id查找他的货架
        List<Items> itemsList = itemsService.findItemsByUserId(user.getId());
        PageInfo<Items> page = new PageInfo<>(itemsList);
        request.setAttribute("page",page);
        // int totalRows = itemsList.size();
        int totalRows = itemsService.countItemsByUserId(user.getId());
        request.setAttribute("totalRows",totalRows);
        return "mine/myItems";
    }
    @RequestMapping("/toAddItems")
    public String toAddCommodity(HttpServletRequest request){
        List<Brand> brandList = brandService.findBrandAll();
        List<Parts> partsList = brandService.findPartsAll();
        request.setAttribute("brandList",brandList);
        request.setAttribute("partsList",partsList);
        return "mine/addItems";
    }
    @RequestMapping("/addItems")
    public String addItems(Items items,HttpServletRequest request){
        //得到当前用户
        SysUser user =  (SysUser) request.getSession().getAttribute("user");
        //设置items的用户id和companyid
        items.setUserId(user.getId());
        items.setCompanyId(user.getCompanyId());
        //处理上传的图片对象，上传到阿里的OSS
        CommonsMultipartFile cf = (CommonsMultipartFile) items.getPic();
        DiskFileItem fi = (DiskFileItem) cf.getFileItem();
        File f = fi.getStoreLocation();
        String key = AliyunOSSClientUtil.getUrl((SysConstant.FOLDER+f.getName()));
        System.out.println(key);
        String key2 = AliyunOSSClientUtil.uploadObject2OSS(AliyunOSSClientUtil.getOSSClient(), f, SysConstant.BACKET_NAME, SysConstant.FOLDER);
        System.err.println(key2);
        String imgUrl="https://"+SysConstant.BACKET_NAME+"."+SysConstant.ENDPOINT+"/"+SysConstant.FOLDER+f.getName();
        //得到图片URL之后存一下
        items.setPicUrl(imgUrl);
        //将items插入进去
        itemsService.insertItems(items);
        return "redirect:myItems";
    }
    @RequestMapping("toEditItems")
    public String toEditItems(int id,HttpServletRequest request){
        request.setAttribute("itemsId",id);
        return "mine/editItems";
    }

    @RequestMapping("editItems")
    public String editItems(Items items, Integer itemsId,HttpServletRequest request){
        Items oldItem = itemsService.findItemsById(itemsId);
        //前端获取的items里面没有id，需要将操作对象id设置进去
        items.setId(itemsId);
        //处理图像
        CommonsMultipartFile cf = (CommonsMultipartFile) items.getPic();
        DiskFileItem fi = (DiskFileItem) cf.getFileItem();
        File f = fi.getStoreLocation();
        System.out.println(AliyunOSSClientUtil.getUrl((SysConstant.FOLDER+f.getName())));
        String imgUrl="https://"+SysConstant.BACKET_NAME+"."+SysConstant.ENDPOINT+"/"+SysConstant.FOLDER+f.getName();
        //没选图片或者没改图片
        if( fi.getSize() ==0 || oldItem.getPicUrl().equals(imgUrl) ){

        }else {
            //删除旧图片
            String picUrl = oldItem.getPicUrl();
            String key = picUrl.substring(picUrl.indexOf(SysConstant.FOLDER));
            if(key != null){
                OSSClient client = new OSSClient(SysConstant.ENDPOINT, SysConstant.ACCESS_KEY_ID, SysConstant.ACCESS_KEY_SECRET);

                client.deleteObject(SysConstant.BACKET_NAME,key);
                client.shutdown();
            }
            //上传新图片
            System.err.println(AliyunOSSClientUtil.uploadObject2OSS(AliyunOSSClientUtil.getOSSClient(), f, SysConstant.BACKET_NAME, SysConstant.FOLDER));
            //改成新路径
            items.setPicUrl(imgUrl);
        }

        itemsService.updateItemsByIdSelective(items);
        return "redirect:myItems";
    }

    @RequestMapping("deleteItems")
    public void deleteItems(Integer id, HttpServletResponse response) throws IOException {
        Items items = itemsService.findItemsById(id);
        //得到key
        String picUrl = items.getPicUrl();
        // picUrl.indexOf(SysConstant.FOLDER)是文件夹名出现的位置
        String key = picUrl.substring( picUrl.indexOf(SysConstant.FOLDER));
        if(key != null){
            OSSClient client = new OSSClient(SysConstant.ENDPOINT, SysConstant.ACCESS_KEY_ID, SysConstant.ACCESS_KEY_SECRET);

            client.deleteObject(SysConstant.BACKET_NAME,key);
            client.shutdown();
        }
        itemsService.deleteItemsById(id);
        response.getWriter().write("1");
    }

}
