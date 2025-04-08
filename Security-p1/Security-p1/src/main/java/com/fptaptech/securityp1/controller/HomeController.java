package com.fptaptech.securityp1.controller;


import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home(HttpSession session, Model model) {
        // Thêm thông tin session vào model để hiển thị trên view
        model.addAttribute("sessionId", session.getId());
        return "index";
    }
    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/admin")
    public String adminPage(HttpSession session,Model model) {
        model.addAttribute("message", "Chào mừng Admin!");
        model.addAttribute("sessionId", session.getId());
        return "admin";
    }



    @GetMapping("/user")
    public String userPage(HttpSession session,Model model) {
        model.addAttribute("message", "Chào mừng User!");
        model.addAttribute("sessionId", session.getId());
        return "user";
    }
}
