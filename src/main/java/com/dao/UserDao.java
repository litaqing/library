package com.dao;

import com.pojo.Book;
import com.pojo.User;

import java.util.List;
import java.util.Map;

public interface UserDao {
    User findByUserName(String userName);

}
