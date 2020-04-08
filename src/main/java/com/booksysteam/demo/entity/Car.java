package com.booksysteam.demo.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 
 * </p>
 *
 * @author deporation
 * @since 2020-04-05
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@AllArgsConstructor
public class Car implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "cid", type = IdType.AUTO)
    private Integer cid;

    @TableField("ISBN")
    private String isbn;

    @TableField("uid")
    private Integer uid;

    @TableField("ccount")
    private Integer ccount;

    @TableField("stat")
    private Boolean stat;


}
