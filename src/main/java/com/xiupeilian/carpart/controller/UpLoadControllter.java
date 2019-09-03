package com.xiupeilian.carpart.controller;

import com.xiupeilian.carpart.constant.SysConstant;
import com.xiupeilian.carpart.service.CompanyService;
import com.xiupeilian.carpart.service.ItemsService;
import com.xiupeilian.carpart.util.AliyunOSSClientUtil;
import com.xiupeilian.carpart.vo.CompanyUploadVo;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

@Controller
@RequestMapping("/upLoad")
public class UpLoadControllter {
    @Autowired
    private ItemsService itemService;
    @Autowired
    private CompanyService companyService;

    @RequestMapping("/myUpload")
    public String upload(HttpServletRequest request) {
        //Items item=itemService.findItemByid(1);
        //request.setAttribute("imgurl",item.getPicUrl());
        return "upload/index";
    }

    @RequestMapping(value = "photoupload", method = {RequestMethod.POST, RequestMethod.GET})
    public void myphotoupload(HttpServletRequest request, @RequestParam("file") MultipartFile file, HttpServletResponse response) throws IOException {
        CommonsMultipartFile cf = (CommonsMultipartFile) file;
        DiskFileItem fi = (DiskFileItem) cf.getFileItem();
        File f = fi.getStoreLocation();
        System.err.println(AliyunOSSClientUtil.uploadObject2OSS(AliyunOSSClientUtil.getOSSClient(), f, SysConstant.BACKET_NAME, SysConstant.FOLDER));
        //String url = AliyunOSSClientUtil.uploadObject2OSS(AliyunOSSClientUtil.getOSSClient(), f, SysConstant.BACKET_NAME, SysConstant.FOLDER);
        System.out.println(AliyunOSSClientUtil.getUrl((SysConstant.FOLDER + f.getName())));
        //System.out.println("ͼƬ�ķ��ʵ�ַ"+"https://"+SysConstant.BACKET_NAME+"."+SysConstant.ENDPOINT+"/"+SysConstant.FOLDER+f.getName());
        String imgUrl = "https://" + SysConstant.BACKET_NAME + "." + SysConstant.ENDPOINT + "/" + SysConstant.FOLDER + f.getName();
//        System.out.println();

        response.getWriter().write(imgUrl);
        System.out.println(imgUrl);

    }

    @RequestMapping("toCompanyUpload")
    public String toCompanyUpload(CompanyUploadVo vo, HttpServletRequest request){
        System.err.println(vo);
        request.setAttribute("picture",vo.getPicture());
        request.setAttribute("id",vo.getId());
        return "company/index";
    }
    @RequestMapping("uploadCompany")
    public void uploadCompany(CompanyUploadVo vo,HttpServletResponse response)throws  Exception{
        System.out.println("42"+vo.getId()+vo.getPicture());
        companyService.uploadCompanyPictureById(vo);
        response.getWriter().write("1");
    }


}
