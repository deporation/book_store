package com.booksysteam.demo.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.booksysteam.demo.entity.User;
import com.booksysteam.demo.service.impl.UserServiceImpl;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author deporation
 * @since 2020-03-26
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserServiceImpl userSerciceImpl;

    //访问/user/login时返回login.jsp
    @RequestMapping("/login")
    public String Login() {
        return "/login";
    }

    //前台用ajax将数据进行打成user，返回值为Map类型通过key：res来进行查询
    @RequestMapping(value = "/login.action", method = { RequestMethod.POST, RequestMethod.GET })
    @ResponseBody
    public Map<String, Boolean> login(@RequestBody User user, HttpSession session) {
        System.out.println(user);
        Map<String, Boolean> map = new HashMap<String, Boolean>();
        boolean res = false;//登录结果默认值为错
        try {
            User user2 = userSerciceImpl.getOne(new QueryWrapper<User>().eq("account", user.getAccount()));
            if (user2.getPasswd().equals(user.getPasswd())) {
                res = true;
                session.setAttribute("user", user2);
            }

        } catch (NullPointerException e) {
            e.printStackTrace();
        }
        map.put("res", res);
        return map;
    }
    //访问/user/signin时返回signin.jsp
    @RequestMapping("/signin")
    public String singin() {
        return "signin";
    }
    //前台用ajax将数据进行打成user，返回值为Map类型通过key：res来进行查询
    @RequestMapping(value = "signin.action", method = { RequestMethod.POST, RequestMethod.GET })
    @ResponseBody
    public Map<String, Boolean> dosignin(@RequestBody User user) {
        Map<String, Boolean> map = new HashMap<String, Boolean>();
        boolean res = false;
        try {//异常捕捉
            user.setPlimit(false);
            //将注册结果保存结果存入res
            res = userSerciceImpl.save(user);
        }catch (Exception e) {
            e.printStackTrace();
        }
        map.put("res", res);
        return map;
    }
}
