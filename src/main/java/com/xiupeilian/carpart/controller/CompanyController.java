package com.xiupeilian.carpart.controller;

import com.aliyun.oss.OSSClient;
import com.xiupeilian.carpart.constant.SysConstant;
import com.xiupeilian.carpart.controller.LoginController;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiupeilian.carpart.model.*;
import com.xiupeilian.carpart.service.BrandService;
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
    @Autowired
    private BrandService brandService;

    /*@RequestMapping("companyList")
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

    }*/

    //展示企业信息
    @RequestMapping("/companyList")
    public String priseList(HttpServletRequest request){

        //获取当前用户
        SysUser user = (SysUser) request.getSession().getAttribute("user");
        //根据当前用户中的企业ID去查询企业表
        Company company = companyService.findCompanyId(user.getCompanyId());
        //判断该企业售卖的产品
        if (!(company.getMain().equals("-1"))) {//有主营的产品信息需要去数据库查询
            //如果有数据的话只能是多种品牌
            Brand main = brandService.finBrandById(company.getMain());
            request.setAttribute("main",main);
        }
        if (!(company.getSingleBrand().equals("-1"))) {
            //单一品牌
            Brand brand = brandService.finBrandById(company.getSingleBrand());
            request.setAttribute("brand",brand);
        }
        if (!(company.getSingleParts().equals("-1"))) {
            //单项配件
            Parts parts = brandService.findPartsByID(company.getSingleParts());
            request.setAttribute("parts",parts);
        }
        if (!(company.getPrime().equals("-1"))) {
            //精品专卖
            Prime prime = brandService.findPrimeByID(company.getPrime());
            request.setAttribute("prime",prime);
        }

        request.setAttribute("company",company);
        return "company/companyList";
    }

    //修改企业宣传
    @RequestMapping("/updatecompany")
    public  String updateCompany(Company company){
        companyService.updateCompany(company);
        return "redirect:companyList";
    }
    }
