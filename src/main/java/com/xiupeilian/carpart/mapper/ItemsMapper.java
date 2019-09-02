package com.xiupeilian.carpart.mapper;

import com.xiupeilian.carpart.base.BaseMapper;
import com.xiupeilian.carpart.model.Items;

import java.util.List;

public interface ItemsMapper extends BaseMapper<Items> {


    List<Items> findItemsByQueryVo(Items items);

    List<Items> findItemsByUserId(Integer id);

    int countItemsByUserId(Integer id);
}