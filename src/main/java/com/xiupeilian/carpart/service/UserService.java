package com.xiupeilian.carpart.service;

import com.xiupeilian.carpart.model.Company;
import com.xiupeilian.carpart.model.Menu;
import com.xiupeilian.carpart.model.Role;
import com.xiupeilian.carpart.model.SysUser;
import com.xiupeilian.carpart.vo.LoginVo;
import com.xiupeilian.carpart.vo.RegisterVo;

import java.util.List;

/**
 * @Description: 用户表相关操作
 * @Author: Tu Xu
 * @CreateDate: 2019/8/21 15:04
 * @Version: 1.0
 **/
public interface UserService {
    public SysUser findUserByLoginNameAndPassword(LoginVo vo);

    List<Menu> findMenusById(int id);

    SysUser findUserByLoginNameAndEmail(LoginVo vo);

    void updateUser(SysUser user);

    SysUser findUserByLoginName(String loginName);

    SysUser findUserByPhone(String phone);

    SysUser findUserByEmail(String email);

    Company findCompanyByName(String companyname);

    void addRegsiter(RegisterVo vo);

    Role findRoleByRoleId(Integer roleId);

    SysUser findUserById(int userId);
}
