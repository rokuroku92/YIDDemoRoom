package com.yiddemoroom.repository;

import com.yiddemoroom.model.Notification;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class NotificationDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;
        
    public List<Notification> queryTodayNotifications(){
        String sql = "SELECT * FROM notification_history WHERE DATE_FORMAT(STR_TO_DATE(create_time, '%Y%m%d%H%i%s'), '%Y-%m-%d') = CURDATE() ORDER BY id DESC;";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Notification.class));
    }
    
    public List<Notification> queryNotificationsByDate(String date){
        String sql = "SELECT * FROM notification_history WHERE DATE_FORMAT(STR_TO_DATE(create_time, '%Y%m%d%H%i%s'), '%Y-%m-%d') = ? ORDER BY id DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Notification.class), date);
    }
    
    public List<Notification> queryAllNotifications(){
        String sql = "SELECT * FROM notification_history ORDER BY id DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Notification.class));
    }
    
}
