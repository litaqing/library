package com.service;

import com.pojo.Book;

import java.util.List;
import java.util.Map;

public interface BookService {
    int addBook(Book book);
    int deleteBookById(int id);
    int updateBook(Book book);
    Book queryById(int id);
    List<Book> queryAllBook();
    List<Book> findList(Map<String,Object> queryMap);
    int getTotal(Map<String,Object> queryMap);
}
