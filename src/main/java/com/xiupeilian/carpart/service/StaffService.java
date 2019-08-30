package com.xiupeilian.carpart.service;

import com.xiupeilian.carpart.model.SysUser;

import java.util.List;

public interface StaffService {

    List<SysUser> selectStaffList();//全查

    List<SysUser> staffListbyName(SysUser so);//条件查询：
}
