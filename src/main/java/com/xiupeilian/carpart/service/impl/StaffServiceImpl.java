package com.xiupeilian.carpart.service.impl;

import com.xiupeilian.carpart.mapper.DymsnMapper;
import com.xiupeilian.carpart.mapper.SysUserMapper;
import com.xiupeilian.carpart.model.SysUser;
import com.xiupeilian.carpart.service.StaffService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class StaffServiceImpl  implements StaffService {


    @Autowired
    private SysUserMapper sysUserMapper;

    @Override
    public List<SysUser> selectStaffList() {
        return sysUserMapper.selectStaffList();
    }

    @Override
    public List<SysUser> staffListbyName(SysUser so) {
        return sysUserMapper.staffListbyName(so);
    }
}
