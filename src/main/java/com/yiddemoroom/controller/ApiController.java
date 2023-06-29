package com.yiddemoroom.controller;

import com.google.gson.Gson;
import com.yiddemoroom.model.AGV;
import com.yiddemoroom.model.AGVId;
import com.yiddemoroom.model.Analysis;
import com.yiddemoroom.model.Notification;
import com.yiddemoroom.model.Station;
import com.yiddemoroom.model.Task;
import com.yiddemoroom.service.AnalysisService;
import com.yiddemoroom.service.HomePageService;
import com.yiddemoroom.service.SendTaskService;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class ApiController {
    
    private final Gson gson = new Gson();
    private static AGV[] agvs;
    private static List<Task> tasks;
    
    @Autowired
    private HomePageService homePageService;
    
    @Autowired
    private AnalysisService analysisService;
    
    @Autowired
    private SendTaskService sendTaskService;
    
    @RequestMapping(value = "/homepage/agvlist", produces = MediaType.APPLICATION_JSON_VALUE + ";charset=UTF-8")
    public String getAGVList(){
        List<AGVId> list = homePageService.queryAGVList();
        return gson.toJson(list);
    }
    
    @RequestMapping(value = "/homepage/task/today", produces = MediaType.APPLICATION_JSON_VALUE)
    public String getTodayTask(){
        List<Task> list = homePageService.queryTodayTasks();
        return gson.toJson(list);
    }
    
    @RequestMapping(value = "/homepage/task/all", produces = MediaType.APPLICATION_JSON_VALUE)
    public String getAllTask(){
        List<Task> list = homePageService.queryAllTasks();
        return gson.toJson(list);
    }
    
    @RequestMapping(value = "/homepage/notification/today", produces = MediaType.APPLICATION_JSON_VALUE)
    public String getTodayNotification(){
        List<Notification> list = homePageService.queryTodayNotifications();
        return gson.toJson(list);
    }
    
    @RequestMapping(value = "/homepage/notification/all", produces = MediaType.APPLICATION_JSON_VALUE)
    public String getAllNotification(){
        List<Notification> list = homePageService.queryAllNotifications();
        return gson.toJson(list);
    }
    
    @RequestMapping(value = "/homepage/stations", produces = MediaType.APPLICATION_JSON_VALUE + ";charset=UTF-8")
    public String getStations(){
        List<Station> list = homePageService.queryStations();
        return gson.toJson(list);
    }
    
    @GetMapping(value = "/homepage/tasks", produces = MediaType.APPLICATION_JSON_VALUE)
    public String getTasksJson() { 
//            tasks = homePageService.queryTodayTasks();
        tasks = homePageService.queryAllTasks();
        return gson.toJson(tasks);
    }
    
    static int tempId;
    @GetMapping(value = "/homepage/agv", produces = MediaType.APPLICATION_JSON_VALUE)
    public String getAGVJson() { 
        if(agvs == null){
            agvs = new AGV[homePageService.queryAGVList().size()];
            for (int i = 0; i < agvs.length; i++) {
                agvs[i] = new AGV();
            }
        }
        LocalDate currentDate = LocalDate.now();
        int year = currentDate.getYear();
        int month = currentDate.getMonthValue();
        int day = currentDate.getDayOfMonth();

        for(int i=0;i<3;i++){
            agvs[i].setStatus((int) (Math.random() * 10) % 3);
            agvs[i].setPlace("Station"+(tempId++%4+1));
            agvs[i].setTask("#"+year+month+day+String.format("%04d", tempId-3));
            agvs[i].setBattery(100-tempId%100);
            agvs[i].setSignal(100-tempId%100);
            tempId+=2;
        }
        
        String jsonString = new Gson().toJson(agvs);
        System.out.println(jsonString);
        return jsonString;
    }
    
//    @RequestMapping(value = "/analysis/all", produces = MediaType.APPLICATION_JSON_VALUE)
//    public String findAnalysisAll(){
//        List<Analysis> list = analysisService.queryAnalysises();
//        return gson.toJson(list);
//    }
    
    @RequestMapping(value = "/analysis/yyyymm", produces = MediaType.APPLICATION_JSON_VALUE)
    public String getAnalysisesYearsAndMonths(){
        List<Map<String, Object>> list = analysisService.getAnalysisesYearsAndMonths();
        return gson.toJson(list);
    }
    // 範例路徑 /analysis/mode?agvId=1&value=202212
    // 範例路徑 /analysis/mode?agvId=1&value=202301
    // 範例路徑 /analysis/mode?agvId=1&value=recently
    @RequestMapping(value = "/analysis/mode", produces = MediaType.APPLICATION_JSON_VALUE)
    public String queryAnalysisesByAGVAndYearAndMonth(@RequestParam("value") String value, @RequestParam("agvId") Integer agvId){
        // value=202212, 202301, recently
        Integer year, month;
        List<Analysis> list = null;
        switch (value) {
            case "recently":
                list = analysisService.queryAnalysisesRecentlyByAGV(agvId);
                break;
            case "all":
                list = analysisService.queryAnalysisesByAGV(agvId);
                break;
            default:
                year = Integer.valueOf(value.substring(0,4));
                month = Integer.valueOf(value.substring(4,6));
                list = analysisService.queryAnalysisesByAGVAndYearAndMonth(agvId, year, month);
                break;
        }
        return gson.toJson(list);
    }
    
    @RequestMapping(value = "/sendTask", produces = MediaType.APPLICATION_JSON_VALUE)
    public String sendTask(@RequestParam("agv") String agv, @RequestParam("start") String start,
                            @RequestParam("terminal") String terminal, @RequestParam("mode") String mode, @RequestParam("time") String time){
        return sendTaskService.insertTask(time, agv, start, terminal, mode) ? "OK" : "FAIL";
    }
    /*
    static int tempId;
    @GetMapping(value = "/json")
    @ResponseBody
    public String getJson() throws IOException { 
        URL url = new URL("http://192.168.1.143:20100/cars");
        String[] arr;
        try (BufferedReader reader = new BufferedReader
                        (new InputStreamReader(url.openStream()))) {
            String line;
            line = reader.readLine().replace("<br>","");
            arr = line.split(",");
        }
        if(agv != null){
            Place place = new Place(Integer.parseInt(arr[1]));
//            Place place = new Place(10);
            Station station = new Station((tempId+2)%4,(tempId+1)%4,(tempId+0)%4,(tempId+2)%4,(tempId+1)%4,(tempId+3)%4,(tempId+2)%4,(tempId+0)%4,
                (tempId+1)%4,(tempId+0)%4,(tempId+0)%4,(tempId+1)%4,(tempId+3)%4,(tempId+0)%4,(tempId+1)%4);
            agv.setStation(station);
            agv.setPlace(place);
            return new Gson().toJson(agv);
        }
        Place place = new Place(1001+tempId++%10);
        Station station = new Station((tempId+2)%4,(tempId+1)%4,(tempId+0)%4,(tempId+2)%4,(tempId+1)%4,(tempId+3)%4,(tempId+2)%4,(tempId+0)%4,
                (tempId+1)%4,(tempId+0)%4,(tempId+0)%4,(tempId+1)%4,(tempId+3)%4,(tempId+0)%4,(tempId+1)%4);
        List<Task> tasks = new ArrayList<>();
        tasks.add(new Task("202301040001",1001,1006,6));
        tasks.add(new Task("202301040002",1007,1002,2));
        tasks.add(new Task("202301040003",1003,1008,8));
        tasks.add(new Task("202301040004",1004,1012,12));
        tasks.add(new Task("202301040005",1013,1005,5));
        agv = new AGV();
        agv.setStatus(1);
        agv.setPlace(place);
        agv.setTask("202301040001");
        agv.setBattery(100);
        agv.setStation(station);
        agv.setTasks(tasks);
        
        String jsonString = new Gson().toJson(agv);
        System.out.println(jsonString);
        return jsonString;
    }
    */
    /*
    @GetMapping(value = "/remove/task/{id}")
    @ResponseBody
    public String removeTask(@PathVariable("id") String id){
        homePage.removeTaskById(id);
        return "ok";
    }
    
    */
}
