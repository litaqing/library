package com.controller;

import com.alibaba.fastjson.JSONObject;
import com.pojo.Book;
import com.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/book")
public class BookController {
    @Autowired
    private BookService bookService;
    @RequestMapping("allBook")
    public String list(Model model){
        List<Book> list =bookService.queryAllBook();
        model.addAttribute("list",list);
        return "allBook";
    }
    @RequestMapping("toAddBook")
    public String toAddBook(){
        return "addBook";
    }
    @RequestMapping("addBook")
    public String addBook(Book book){
    bookService.addBook(book);
    return "redirect:/book/allBook";
    }
    @RequestMapping("/del/{id}")
    public String deleteBook(@PathVariable("id")int id){
    bookService.deleteBookById(id);
    return "redirect:/book/allBook";
    }
    @RequestMapping("toUpdateBook")
    public String toUpdateBook(Model model,int id){
        model.addAttribute("book",bookService.queryById(id));
        return "updateBook";
    }
    @RequestMapping("updateBook")
    public String updateBook(Model model,Book book){
        bookService.updateBook(book);
        book=bookService.queryById(book.getId());
        model.addAttribute("book",book);
        return "redirect:/book/allBook";
    }
    @RequestMapping("getList")
    public String getList(Integer pageSize, Integer pageNumber, String searchText, HttpServletRequest request,
                          HttpServletResponse response){
        Map<String,Object> res= new HashMap<String, Object>();
        Map<String,Object> queryMap=new HashMap<String, Object>();
        if (pageNumber<=1){
            pageNumber=1;
        }
        if (searchText==null){
            queryMap.put("name","'%"+""+"%'");
        }else{
            queryMap.put("name","%"+searchText+"%");
        }


        queryMap.put("startIndex",(pageNumber -1)*pageSize);
        queryMap.put("rows",pageSize);
        res.put("rows",bookService.findList(queryMap));
        res.put("total",bookService.getTotal(queryMap));
        return JSONObject.toJSON(res).toString();
    }

}
