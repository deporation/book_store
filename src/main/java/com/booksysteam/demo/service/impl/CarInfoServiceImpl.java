package com.booksysteam.demo.service.impl;

import com.booksysteam.demo.entity.CarInfo;
import com.booksysteam.demo.mapper.CarInfoMapper;
import com.booksysteam.demo.service.ICarInfoService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * VIEW 服务实现类
 * </p>
 *
 * @author deporation
 * @since 2020-03-26
 */
@Service
public class CarInfoServiceImpl extends ServiceImpl<CarInfoMapper, CarInfo> implements ICarInfoService {

}
