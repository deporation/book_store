package com.booksysteam.demo.service.impl;

import com.booksysteam.demo.entity.Comment;
import com.booksysteam.demo.mapper.CommentMapper;
import com.booksysteam.demo.service.ICommentService;
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
public class CommentServiceImpl extends ServiceImpl<CommentMapper, Comment> implements ICommentService {

}
