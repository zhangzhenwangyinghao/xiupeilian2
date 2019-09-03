package com.xiupeilian.carpart.service;

import com.xiupeilian.carpart.model.Company;
import com.xiupeilian.carpart.vo.CompanyUploadVo;

/**
 * @Description:
 * @Author: Tu Xu
 * @CreateDate: 2019/9/2 13:33
 * @Version: 1.0
 **/
public interface CompanyService {
    Company findCompanyId(int id);

    void updateCompany(Company company);

    void uploadCompanyPictureById(CompanyUploadVo vo);
}
