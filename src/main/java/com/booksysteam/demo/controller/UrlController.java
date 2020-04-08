package com.booksysteam.demo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author deporation
 * @since 2020-03-26
 */
@Controller
@RequestMapping("/")
public class UrlController {
    @RequestMapping("")
    public String index(HttpSession session) {
        System.out.println(session.getAttribute("user"));
        if(session.getAttribute("user") == null){
            return "redirect:/user/login";
        }
        return "index";
    }
}
