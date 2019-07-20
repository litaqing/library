package com.controller;


import com.pojo.User;
import com.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/system")
public class SystemController {
    @Autowired
    private UserService userService;



    @RequestMapping(value = "/login",method= RequestMethod.POST)
    @ResponseBody
    public Map<String,String> login(
           User user,
            HttpServletRequest request
    ){
        System.out.println("进来了");
        String url = request.getRequestURI();
        System.out.println("url = " + url);
        ModelAndView mv =new ModelAndView();
        Map<String, String> ret = new HashMap<String, String>();
        if(StringUtils.isEmpty(user.getUserName())){
            ret.put("type", "error");
            ret.put("msg", "用户名不能为空!");

            return ret;
        }
        if(StringUtils.isEmpty(user.getUserName())){
            ret.put("type", "error");
            ret.put("msg", "密码不能为空!");

            return ret;
        }



            User user1 = userService.findByUserName(user.getUserName());
            if(user1 == null){
                ret.put("type", "error");
                ret.put("msg", "不存在该用户!");

                return ret;
            }
            if(!user1.getPassWord().equals(user.getPassWord())){
                System.out.println(user1.getPassWord());
                System.out.println(user.getPassWord());
                ret.put("type", "error");
                ret.put("msg", "密码错误!");
                return ret;
            }
        ret.put("type", "success");
        ret.put("msg", "登录成功!");

        return ret;
    }
    @RequestMapping(value = "/toHome",method=RequestMethod.GET)
    public ModelAndView index(ModelAndView model){
        model.setViewName("system/home");
        return model;
    }

    @RequestMapping(value = "/toLogin",method=RequestMethod.GET)
    public ModelAndView login(ModelAndView model){
        model.setViewName("system/login");
        return model;
    }
    @RequestMapping(value = "/toRegister",method=RequestMethod.GET)
    public String register(){
        return "system/register";
    }
    @RequestMapping(value = "/register",method= RequestMethod.POST)
    @ResponseBody
    public Map<String,String> register(
            User user,
            HttpServletRequest request
    ){
        System.out.println(user);
        String url = request.getRequestURI();
        System.out.println("url = " + url);
        Map<String, String> ret = new HashMap<String, String>();
        if(StringUtils.isEmpty(user.getUserName())){
            ret.put("type", "error");
            ret.put("msg", "用户名不能为空!");

            return ret;
        }
        if(StringUtils.isEmpty(user.getPassWord())){
            ret.put("type", "error");
            ret.put("msg", "密码不能为空!");
            return ret;
        }
        userService.addUser(user);
        ret.put("type", "success");
        ret.put("msg", "注册成功!");
        return ret;
    }

    @RequestMapping(value = "/toFenye",method=RequestMethod.GET)
    public ModelAndView toFenye(ModelAndView model){
        model.setViewName("system/bookCirculate");
        return model;
    }


    @RequestMapping(value = "/toTestTarget",method=RequestMethod.GET)
    public ModelAndView toTestTarget(ModelAndView model){
        model.setViewName("system/bookUpdate");
        return model;
    }





}
