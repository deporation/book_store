package com.booksysteam.demo.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 
 * </p>
 *
 * @author deporation
 * @since 2020-03-26
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Book implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId("ISBN")
    private String isbn;

    @TableField("bookname")
    private String bookname;

    @TableField("autor")
    private String autor;

    @TableField("transalter")
    private String transalter;

    @TableField("press")
    private String press;

    @TableField("editor")
    private String editor;

    @TableField("publisher")
    private String publisher;

    @TableField("edition")
    private Integer edition;

    @TableField("pages")
    private Integer pages;

    @TableField("price")
    private Float price;

    @TableField("bcount")
    private Integer bcount;

    @TableField("btime")
    private LocalDateTime btime;

    @TableField("detail")
    private String detail;

}
