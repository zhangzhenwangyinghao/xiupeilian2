package com.xiupeilian.carpart.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiupeilian.carpart.model.Notice;
import com.xiupeilian.carpart.model.SysUser;
import com.xiupeilian.carpart.service.StaffService;
import com.xiupeilian.carpart.service.UserService;
import com.xiupeilian.carpart.service.impl.StaffServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * @Description: 员工管理模板
 * @Author: Tu Xu
 * @CreateDate: 2019/8/22 9:44
 * @Version: 1.0
 **/
@Controller
@RequestMapping("/staff")
public class StaffController {

    @Autowired
    private UserService userService;
    @Autowired
    private StaffService staffService;

    @RequestMapping("/staffList")
    public String staffList(Integer pageSize, Integer pageNum, HttpServletRequest request, HttpServletResponse response) throws IOException {
        pageSize = pageSize == null ? 10 : pageSize;
        pageNum = pageNum == null ? 1 : pageNum;
        PageHelper.startPage(pageNum, pageSize);
        //查询全部
        List<SysUser> list = staffService.selectStaffList();
        PageInfo<SysUser> page = new PageInfo<>(list);
        request.setAttribute("staffList", list);
        request.setAttribute("page", page);
        return "index/staffList";
    }

    //多条件查找
    @RequestMapping("/staffListbyName")
    public String staffListbyName(SysUser so, Integer pageSize, Integer pageNum, HttpServletRequest request, HttpServletResponse response) throws IOException {
        pageSize = pageSize == null ? 10 : pageSize;
        pageNum = pageNum == null ? 1 : pageNum;
        PageHelper.startPage(pageNum, pageSize);
        //查询全部
        List<SysUser> list = staffService.staffListbyName(so);
        PageInfo<SysUser> page = new PageInfo<>(list);
        request.setAttribute("staffList", list);
        request.setAttribute("page", page);
        request.setAttribute("so", so);
        return "index/staffList";
    }

//
}  //添加员工：
//    @RequestMapping("/toAddStaff")
//    public String


