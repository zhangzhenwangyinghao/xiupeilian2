package com.xiupeilian.carpart.mapper;

import com.xiupeilian.carpart.base.BaseMapper;
import com.xiupeilian.carpart.model.SysUser;
import com.xiupeilian.carpart.vo.LoginVo;

import java.util.List;

public interface SysUserMapper extends BaseMapper<SysUser> {

    SysUser findUserByLoginNameAndPassword(LoginVo vo);

    SysUser findUserByLoginNameAndEmail(LoginVo vo);

    SysUser findUserByLoginName(String loginName);

    SysUser findUserByPhone(String phone);

    SysUser findUserByEmail(String email);

    List<SysUser> selectStaffList();

    List<SysUser> staffListbyName(SysUser so);

    SysUser findUserById(int userId);
}