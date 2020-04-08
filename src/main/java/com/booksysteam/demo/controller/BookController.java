package com.booksysteam.demo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.booksysteam.demo.entity.Book;
import com.booksysteam.demo.entity.CommentInfo;
import com.booksysteam.demo.entity.User;
import com.booksysteam.demo.service.impl.BookServiceImpl;
import com.booksysteam.demo.service.impl.CommentInfoServiceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author deporation
 * @since 2020-03-26
 */
@Controller
@RequestMapping("/book")
public class BookController {

    @Autowired
    private BookServiceImpl bookServiceImpl;
    @Autowired
    private CommentInfoServiceImpl commentInfoServiceImpl;

    // 管理员添加书籍,如果不是管理员返回主页面,是的话跳转addBook.jsp
    @RequestMapping("/addBook")
    public String addbook(HttpSession session) {
        if (!((User) session.getAttribute("user")).getPlimit()) {
            return "/index";
        }
        return "addBook";
    }

    @RequestMapping(value = "addBook.action", method = { RequestMethod.POST, RequestMethod.GET })
    @ResponseBody // 加此注解意味着返回值为数据，不是jsp
    public Map<String, Boolean> addbook(@RequestBody Book book) {
        System.out.println(book);
        Map<String, Boolean> map = new HashMap<String, Boolean>();
        boolean res = false;
        res = bookServiceImpl.save(book);
        map.put("res", res);
        return map;
    }

    @RequestMapping(value = "search.action", method = { RequestMethod.POST, RequestMethod.GET })
    public String selectBook(@RequestParam(value = "bookname") String bookname, Model model) {
        try {
            // 将书名进行模糊字符段匹配，eg:"abc"->"%a%b%c%",类似循环
            bookname = "%" + bookname.chars().mapToObj(e -> (char) e).map(e -> e.toString()).map(e -> e = e + "%")
                    .collect(Collectors.joining()) + "%";

            List<Book> books = bookServiceImpl.list(new QueryWrapper<Book>().like("bookname", bookname));
            model.addAttribute("books", books);

        } catch (Exception e) {
            // TODO: handle exception
            model.addAttribute("books", null);
            return "search";// 查询页面的jsp
        }

        return "search";// 查询页面的jsp
    }

    // 书籍查询页面，提供书籍ISBN，返回书籍的详细信息及对应评论
    @RequestMapping(value = "Bookdetail", method = { RequestMethod.POST, RequestMethod.GET })
    public String detail(@RequestParam(value = "isbn") String isbn, Model model) {
        Book book = bookServiceImpl.getById(isbn);
        List<CommentInfo> commentInfos = commentInfoServiceImpl.list(new QueryWrapper<CommentInfo>());
        Map<String, Object> res = new HashMap<>();
        res.put("book", book);
        res.put("comments", commentInfos);
        model.addAttribute("details", res);
        return "detail";
    }

    @RequestMapping("addBooknum")
    public String add() {
        return "addbooknum";
    }

    @RequestMapping(value = "addBooknum.action", method = { RequestMethod.POST, RequestMethod.GET })
    @ResponseBody
    public Map<String,Object> add(@RequestParam(value = "isbn") String isbn, @RequestParam(value = "bcount") int bcount,
            Model model) {
        Map<String,Object>res = new HashMap<>();
        Book book = bookServiceImpl.getById(isbn);
        book.setBcount(book.getBcount() + bcount);
        Boolean re = bookServiceImpl.updateById(book);
        res.put("res", re);
        res.put("url", "/book/Bookdetail?isbn=" + book.getIsbn());
        return res;
    }
  
}
