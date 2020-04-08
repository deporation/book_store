package com.booksysteam.demo.service.impl;

import com.booksysteam.demo.entity.Book;
import com.booksysteam.demo.mapper.BookMapper;
import com.booksysteam.demo.service.IBookService;
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
public class BookServiceImpl extends ServiceImpl<BookMapper, Book> implements IBookService {

}
