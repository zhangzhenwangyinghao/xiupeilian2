package com.xiupeilian.carpart.vo;

import com.xiupeilian.carpart.model.Brand;
import com.xiupeilian.carpart.model.Company;
import com.xiupeilian.carpart.model.Parts;
import com.xiupeilian.carpart.model.Prime;

/**
 * @PackageName:com.xiupeilian.carpart.vo ClassName:PriseVo
 * @author: 小白
 * @date 2019/8/30 16:26
 */
public class PriseVo {
    private Company company;
    private Brand brand;
    private Parts parts;
    private Prime prime;

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    public Brand getBrand() {
        return brand;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public Parts getParts() {
        return parts;
    }

    public void setParts(Parts parts) {
        this.parts = parts;
    }

    public Prime getPrime() {
        return prime;
    }

    public void setPrime(Prime prime) {
        this.prime = prime;
    }

    @Override
    public String toString() {
        return "PriseVo{" +
                "company=" + company +
                ", brand=" + brand +
                ", parts=" + parts +
                ", prime=" + prime +
                '}';
    }
}
