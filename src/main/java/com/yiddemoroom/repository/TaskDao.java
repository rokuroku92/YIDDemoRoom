package com.yiddemoroom.repository;

import com.yiddemoroom.model.Task;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class TaskDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;
        
    public List<Task> queryTodayTasks(){
        String sql = "SELECT * FROM task_history WHERE DATE_FORMAT(STR_TO_DATE(create_task_time, '%Y%m%d%H%i%s'), '%Y-%m-%d') = CURDATE() ORDER BY id DESC;";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Task.class));
    }
    
    public List<Task> queryTasksByDate(String date){
        String sql = "SELECT * FROM task_history WHERE DATE_FORMAT(STR_TO_DATE(create_task_time, '%Y%m%d%H%i%s'), '%Y-%m-%d') = ? ORDER BY id DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Task.class), date);
    }
    
    public List<Task> queryAllTasks(){
        String sql = "SELECT * FROM task_history ORDER BY id DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Task.class));
    }
    
}
