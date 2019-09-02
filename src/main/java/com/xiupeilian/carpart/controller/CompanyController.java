package com.xiupeilian.carpart.controller;

import com.xiupeilian.carpart.constant.SysConstant;
import com.xiupeilian.carpart.controller.LoginController;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiupeilian.carpart.model.Company;
import com.xiupeilian.carpart.model.Notice;
import com.xiupeilian.carpart.model.SysUser;
import com.xiupeilian.carpart.service.CompanyService;
import com.xiupeilian.carpart.service.UserService;
import com.xiupeilian.carpart.util.AliyunOSSClientUtil;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * @Description:
 * @Author:
 * @CreateDate: 2019/8/30 9:26
 * @Version: 1.0
 **/

@Controller
@RequestMapping("/company")
public class CompanyController {

    @Autowired
    private CompanyService companyService;
    @Autowired
    private UserService userService;

   /* @RequestMapping("companyList")
    public String toCompany(Integer pageSize, Integer pageNum, HttpServletRequest request){

        pageSize=pageSize==null?2:pageSize;
        pageNum=pageNum==null?1:pageNum;
        PageHelper.startPage(pageNum,pageSize);
        //查询全部
        List<Company> list=companyService.findCompany();
        PageInfo<Company> page=new PageInfo<>(list);
        request.setAttribute("page",page);

        return "company/companyList";


    }*/

    @RequestMapping("companyList")
    public String toCompany(HttpServletRequest request) {

        int userId= (int) request.getSession().getAttribute("id");

        SysUser user=userService.findUserById(userId);
       // System.out.println("id是:"+id);
        int id=user.getCompanyId();
       // System.out.println("id:"+id);
        Company company = companyService.findCompanyId(id);
        System.out.println(company.getCompanyName());
        request.setAttribute("company", company);

        return "company/companyList";

    }
    @RequestMapping("/toUpload")
    public void toUpload(@RequestParam("file") MultipartFile file, HttpServletResponse response) throws IOException {
        CommonsMultipartFile cf = (CommonsMultipartFile) file;
        DiskFileItem fi = (DiskFileItem) cf.getFileItem();
        File f = fi.getStoreLocation();
        System.err.println(AliyunOSSClientUtil.uploadObject2OSS(AliyunOSSClientUtil.getOSSClient(), f, SysConstant.BACKET_NAME, SysConstant.FOLDER));
        //String url = AliyunOSSClientUtil.uploadObject2OSS(AliyunOSSClientUtil.getOSSClient(), f, SysConstant.BACKET_NAME, SysConstant.FOLDER);
        System.out.println(AliyunOSSClientUtil.getUrl((SysConstant.FOLDER + f.getName())));
        //System.out.println("图片的访问地址"+"https://"+SysConstant.BACKET_NAME+"."+SysConstant.ENDPOINT+"/"+SysConstant.FOLDER+f.getName());
        String imgUrl = "https://" + SysConstant.BACKET_NAME + "." + SysConstant.ENDPOINT + "/" + SysConstant.FOLDER + f.getName();
//        System.out.println();

        response.getWriter().write(imgUrl);
        System.out.println(imgUrl);
    }
}
