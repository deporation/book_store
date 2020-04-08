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
 * @since 2020-03-27
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("carInfo")
public class CarInfo implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableField("cid")
    private Integer cid;

    @TableField("pri")
    private Double pri;

    @TableField("stat")
    private Boolean stat;

    @TableField("uid")
    private Integer uid;

    @TableField("ISBN")
    private String isbn;

    @TableField("bookname")
    private String bookname;

    @TableField("ccount")
    private Integer ccount;

    @TableField("cover")
    private String cover;


}
