package com.booksysteam.demo.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.booksysteam.demo.entity.Comment;
import com.booksysteam.demo.entity.User;
import com.booksysteam.demo.service.impl.CommentServiceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * <p>
 * VIEW 前端控制器
 * </p>
 *
 * @author deporation
 * @since 2020-03-26
 */
@Controller
@RequestMapping("/comment-info")
public class CommentInfoController {
    @Autowired
    private CommentServiceImpl commentServiceImpl;

    @RequestMapping(value = "addComment.action", method = { RequestMethod.POST, RequestMethod.GET })
    @ResponseBody
    public Map<String,Boolean> addComment(@RequestParam(value = "isbn") String isbn,@RequestParam(value = "content") String content,HttpSession session){
        User user =  (User)session.getAttribute("user");
        Boolean res = false;
        try {
            Comment comment = new Comment(null, user.getUid(), isbn, content);
            res = commentServiceImpl.save(comment);
        } catch (Exception e) {
            //TODO: handle exception
            e.printStackTrace();
        }
        Map<String, Boolean> map  = new HashMap<>();
        map.put("res", res);
        return map;
    }
}
