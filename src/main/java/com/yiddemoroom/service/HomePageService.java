package com.yiddemoroom.service;

import com.yiddemoroom.model.AGVId;
import com.yiddemoroom.model.Mode;
import com.yiddemoroom.model.Notification;
import com.yiddemoroom.model.Station;
import com.yiddemoroom.model.Task;
import com.yiddemoroom.repository.AGVIdDao;
import com.yiddemoroom.repository.ModeDao;
import com.yiddemoroom.repository.NotificationDao;
import com.yiddemoroom.repository.StationDao;
import com.yiddemoroom.repository.TaskDao;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HomePageService {
    
    @Autowired
    private AGVIdDao agvIdDao;
    
    @Autowired
    private TaskDao taskDao;
    
    @Autowired
    private NotificationDao notificationDao;
    
    @Autowired
    private StationDao StationDao;
    
    @Autowired
    private ModeDao modeDao;
    
    public List<AGVId> queryAGVList(){
        return agvIdDao.queryAGVList();
    }
    
    public List<Task> queryTodayTasks(){
        return taskDao.queryTodayTasks();
    }
    
    public List<Task> queryTasksByDate(String date){
        return taskDao.queryTasksByDate(date);
    }
    
    public List<Task> queryAllTasks(){
        return taskDao.queryAllTasks();
    }
    
    public boolean updateTaskStatus(String taskNumber, int status){
        return taskDao.updateTaskStatus(taskNumber, status);
    }
    
    public List<Notification> queryTodayNotifications(){
        return notificationDao.queryTodayNotifications();
    }
    
    public List<Notification> queryNotificationsByDate(String date){
        return notificationDao.queryNotificationsByDate(date);
    }
    
    public List<Notification> queryAllNotifications(){
        return notificationDao.queryAllNotifications();
    }
    
    public List<Station> queryStations(){
        return StationDao.queryStations();
    }
    
    public boolean cancelTask(String taskNumber){
        return taskDao.cancelTask(taskNumber);
    }
    
    public List<Mode> queryModes(){
        return modeDao.queryModes();
    }
    
    
}
