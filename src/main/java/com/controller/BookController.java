package com.controller;

import com.alibaba.fastjson.JSONObject;
import com.page.Page;
import com.pojo.Book;
import com.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//图书得控制器
@Controller
@RequestMapping("/book")
public class BookController {
    @Autowired
    private BookService bookService;

    @RequestMapping(value = "/getList", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getList(
            Page page, @RequestParam(value = "findName", required = false, defaultValue = "") String findName
    ) {
        Map<String, Object> ret = new HashMap<String, Object>();
        Map<String, Object> queryMap = new HashMap<String, Object>();

        System.out.println(page);
        System.out.println(findName);
        queryMap.put("findName", "%" + findName + "%");
        queryMap.put("offset", page.getOffset());
        queryMap.put("pageSize", page.getPageSize());
        ret.put("list", bookService.findList(queryMap));
        ret.put("total", bookService.getTotal(queryMap));
        return ret;
    }

    @RequestMapping(value = "/toAddBook", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> toaddBook(
            Book book
    ) {
        System.out.println(book);
        Map<String, Object> ret = new HashMap<String, Object>();
        if (book.getNumber() <=0) {
            ret.put("msg", "数量不能小于0");
        }else{
            bookService.addBook(book);
            ret.put("msg", "添加成功");
        }

        return ret;
    }

    @RequestMapping(value = "/toDelBook", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> todelBook(
            @RequestParam(value = "id", required = false, defaultValue = "") Integer id
    ) {
        Map<String, Object> ret = new HashMap<String, Object>();
        if (id < 0 || id == null) {
            ret.put("msg", "id错误");
        }
        bookService.deleteBookById(id);
        ret.put("msg", "删除成功");
        return ret;
    }

    @RequestMapping(value = "/toUpdateBook", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updateId(
            Book book
    ) {
        System.out.println(book);
        Map<String, Object> ret = new HashMap<String, Object>();
        if (book.getId() < 0) {
            ret.put("msg", "id错误");
        }
        bookService.updateBook(book);
        ret.put("msg", "更改成功");
        return ret;
    }

    @RequestMapping(value = "/toLendBook", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> toLendBook(
            @RequestParam(value = "id", required = false, defaultValue = "") Integer id
    ) {
        Map<String, Object> ret = new HashMap<String, Object>();
        Book book = bookService.queryById(id);
        System.out.println(book);
        if (book.getNumber() <= book.getLendNumber()) {
            ret.put("msg", "数量不足");
        } else if (book.getNumber() ==(book.getLendNumber()-1)) {
            book.setLendNumber(book.getLendNumber() + 1);
            book.setIsLend("全部借出");
            bookService.updateBook(book);
            ret.putIfAbsent("msg", "借书成功");
        } else {
            book.setLendNumber(book.getLendNumber() + 1);
            book.setIsLend("有库存");
            bookService.updateBook(book);
            ret.putIfAbsent("msg", "借书成功");
        }
        return ret;
    }

    @RequestMapping(value = "/toYetBook", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> toYetBook(
            @RequestParam(value = "id", required = false, defaultValue = "") Integer id
    ) {
        Map<String, Object> ret = new HashMap<String, Object>();
        Book book = bookService.queryById(id);
        if (book.getLendNumber()<=0){
            ret.putIfAbsent("msg", "未借书");
        }else{
            book.setLendNumber(book.getLendNumber()-1);
            book.setIsLend("有库存");
            bookService.updateBook(book);
            ret.putIfAbsent("msg", "还书成功");
        }
        return ret;
    }
}
