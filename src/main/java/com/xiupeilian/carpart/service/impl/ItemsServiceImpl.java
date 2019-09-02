package com.xiupeilian.carpart.service.impl;

import com.xiupeilian.carpart.mapper.ItemsMapper;
import com.xiupeilian.carpart.model.Items;
import com.xiupeilian.carpart.service.ItemsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Description:
 * @Author: Tu Xu
 * @CreateDate: 2019/8/28 9:33
 * @Version: 1.0
 **/
@Service
public class ItemsServiceImpl implements ItemsService {

    @Autowired
    private ItemsMapper itemsMapper;

    @Override
    public List<Items> findItemsByQueryVo(Items items) {
        return itemsMapper.findItemsByQueryVo(items);
    }

    @Override
    public void insertItems(Items items) {
        itemsMapper.insertSelective(items);
    }

    @Override
    public Items findItemsById(Integer itemsId) {
        return itemsMapper.selectByPrimaryKey(itemsId);
    }

    @Override
    public void updateItemsByIdSelective(Items items) {
        itemsMapper.updateByPrimaryKeySelective(items);
    }

    @Override
    public void deleteItemsById(Integer id) {
        itemsMapper.deleteByPrimaryKey(id);
    }

    @Override
    public List<Items> findItemsByUserId(Integer id) {
        return itemsMapper.findItemsByUserId(id);
    }

    @Override
    public int countItemsByUserId(Integer id) {
        return itemsMapper.countItemsByUserId( id);
    }
}
