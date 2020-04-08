package com.booksysteam.demo.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * VIEW
 * </p>
 *
 * @author deporation
 * @since 2020-03-26
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("commentInfo")
public class CommentInfo implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableField("uid")
    private Integer uid;

    @TableField("ISBN")
    private String isbn;

    @TableField("content")
    private String content;

    @TableField("uname")
    private String uname;

    @TableField("bookname")
    private String bookname;


}
