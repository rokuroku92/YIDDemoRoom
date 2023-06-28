package com.yiddemoroom.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/agv")
public class AgvController {
    
    @GetMapping(value = "/")
    public String indexHomePage() {
        return "agv";
    }
    
    @GetMapping(value = "/send")
    public String indexSend() {
        return "send";
    }
    
    @GetMapping(value = "/analysis")
    public String indexAnalysis() {
        return "analysis";
    }
    
    @GetMapping(value = "/history")
    public String indexHistory() {
        return "history";
    }
    
}
