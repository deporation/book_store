package com.booksysteam.demo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.booksysteam.demo.entity.Book;
import com.booksysteam.demo.entity.Car;
import com.booksysteam.demo.entity.CarInfo;
import com.booksysteam.demo.entity.User;
import com.booksysteam.demo.service.impl.BookServiceImpl;
import com.booksysteam.demo.service.impl.CarInfoServiceImpl;
import com.booksysteam.demo.service.impl.CarServiceImpl;

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
@RequestMapping("/car")
public class CarController {
    @Autowired
    private BookServiceImpl bookServiceImpl;
    @Autowired
    private CarInfoServiceImpl carInfoServiceImpl;
    @Autowired
    private CarServiceImpl carServiceImpl;

    // 将carinfo转换为car进行插入和更新
    private Car CarInfoTocar(CarInfo carInfo) {
        return new Car(carInfo.getCid(), carInfo.getIsbn(), carInfo.getUid(), carInfo.getCcount(), carInfo.getStat());
    }

    // 查看自己购物车内容
    @RequestMapping(value = "check", method = { RequestMethod.POST, RequestMethod.GET })
    public String check(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        List<CarInfo> carInfos = carInfoServiceImpl
                .list(new QueryWrapper<CarInfo>().eq("uid", user.getUid()).eq("stat", false));
        model.addAttribute("cars", carInfos);
        return "car";
    }

    // 购物车添加记录
    @RequestMapping(value = "add", method = { RequestMethod.POST, RequestMethod.GET })
    @ResponseBody
    public Map<String, Integer> add(@RequestBody Car car, HttpSession session) {
        Boolean res = false;
        Map<String, Integer> map = new HashMap<>();
        try {
            try {
                Car car2 = carServiceImpl.getOne(new QueryWrapper<Car>().eq("isbn", car.getIsbn()).eq("stat", false));
                car = car2.setCcount(car2.getCcount() + car.getCcount());
                res = carServiceImpl.update(car,
                        new UpdateWrapper<Car>().eq("uid", car.getUid()).eq("isbn", car.getIsbn()).eq("stat", false));
                map.put("res", res == true ? 0 : 1);
                return map;
            } catch (Exception e) {
                // TODO: handle exception
                e.printStackTrace();
            }
            car.setUid(((User) session.getAttribute("user")).getUid());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (car.getUid() == null) {
                map.put("res", 2);
                return map;
            }
            res = carServiceImpl.saveOrUpdate(car);
        }
        map.put("res", res == true ? 0 : 1);
        return map;
    }

    // 购物车更新记录
    @RequestMapping(value = "update", method = { RequestMethod.POST, RequestMethod.GET })
    public String update(@RequestBody List<CarInfo> cars) {
        List<Car> cars2 = cars.stream().map(e -> CarInfoTocar(e)).collect(Collectors.toList());
        carServiceImpl.saveOrUpdateBatch(cars2);
        return "car";
    }

    // 支付行为
    @RequestMapping(value = "pay", method = { RequestMethod.POST, RequestMethod.GET })
    @ResponseBody
    public Map<String,Double> pay(@RequestParam(value = "cid") int cid, @RequestParam(value = "ccount") int ccount, Model model) {
        Car car = carServiceImpl.getById(cid);
        Map<String,Double> resultMap = new HashMap<>();
        System.out.println(car);
        car.setCcount(ccount);
        Book book = bookServiceImpl.getOne(new QueryWrapper<Book>().eq("isbn", car.getIsbn()));
        System.out.println(book);
        if (book.getBcount() < car.getCcount()) {
            resultMap.put("res", -1.0);
            return resultMap;
        }
        bookServiceImpl.updateById(book.setBcount(book.getBcount() - ccount));
        carServiceImpl.update(car.setStat(true), new UpdateWrapper<Car>().eq("cid", car.getCid()));
        double sum = book.getPrice() * car.getCcount();
        System.out.println(sum);
        resultMap.put("res", sum);
        return resultMap;
    }

    @RequestMapping(value = "payall", method = { RequestMethod.POST, RequestMethod.GET })
    @ResponseBody
    public Map<String,Double> pay(@RequestBody List<Map<String, Integer>> car) {
        double sum = 0;
        List<Integer> cids = new ArrayList<>();
        List<Car> cars = carServiceImpl.list(new QueryWrapper<Car>().in("cid", cids));
        Map<String,Double> resultMap = new HashMap<>();
        for (Map<String, Integer> map : car) {
            cids.add(map.get("cid"));
        }
        List<String> isbns = cars.stream().map(e -> e.getIsbn()).collect(Collectors.toList());
        List<Book> books = bookServiceImpl.list(new QueryWrapper<Book>().in("isbn", isbns));
        Map<String, Book> map = new HashMap<>();
        Map<String, Car> maps = new HashMap<>();
        books.stream().forEach(e -> map.put(e.getIsbn(), e));
        for (Map<String, Integer> cMap : car) {
            carServiceImpl.updateById(new Car(cMap.get("cid"), null, null, cMap.get("ccount"), null));
        }
        cars = carServiceImpl.list(new QueryWrapper<Car>().in("cid", cids));
        cars.stream().forEach(e -> maps.put(e.getIsbn(), e));
        for (String isbn : isbns) {
            if (maps.get(isbn).getCcount() > map.get(isbn).getBcount()) {
                resultMap.put("res", -1.0);
                return resultMap;
            }
            map.get(isbn).setBcount(map.get(isbn).getBcount() - maps.get(isbn).getCcount());
        }
        Set<String> set = new HashSet<>(isbns);
        for (String isbn : set) {
            sum = (maps.get(isbn).getCcount() * map.get(isbn).getPrice()) + sum;
            bookServiceImpl.updateById(map.get(isbn));
        }
        for (Map<String, Integer> cMap : car) {
            carServiceImpl.updateById(new Car(cMap.get("cid"), null, null, cMap.get("ccount"), true));
        }
        resultMap.put("res", sum);
        return resultMap;
    }

}
