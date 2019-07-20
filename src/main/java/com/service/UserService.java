package com.service;

import com.pojo.Book;
import com.pojo.User;

import java.util.List;
import java.util.Map;

public interface UserService {
    User findByUserName(String userName);
    int addUser(User user);
}
