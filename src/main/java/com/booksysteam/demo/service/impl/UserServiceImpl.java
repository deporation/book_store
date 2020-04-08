package com.booksysteam.demo.service.impl;

import com.booksysteam.demo.entity.User;
import com.booksysteam.demo.mapper.UserMapper;
import com.booksysteam.demo.service.IUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author deporation
 * @since 2020-03-26
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

}
