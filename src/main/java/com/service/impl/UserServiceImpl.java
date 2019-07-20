package com.service.impl;

import com.dao.BookDao;
import com.dao.UserDao;
import com.pojo.Book;
import com.pojo.User;
import com.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;


    @Override
    public User findByUserName(String userName) {
        return userDao.findByUserName(userName);
    }

    @Override
    public int addUser(User user) {
        return userDao.addUser(user);
    }
}
