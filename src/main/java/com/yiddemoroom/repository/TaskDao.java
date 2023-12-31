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
        String sql = "SELECT * FROM task_history WHERE DATE_FORMAT(STR_TO_DATE(create_task_time, '%Y%m%d%H%i%s'), '%Y-%m-%d') = CURDATE() AND status != -1 ORDER BY id;";
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
    
    public String selectLastTaskNumber(){
        String sql = "SELECT task_number FROM task_history ORDER BY task_number DESC LIMIT 1;";
        return jdbcTemplate.queryForObject(sql, String.class);
    }
    
    public boolean insertTask(String taskNumber, String creatTime, String agv, String start, String terminal,String mode){
        String sql = "INSERT INTO `task_history`(`task_number`, `create_task_time`, `agv_id`, `start_id`, `terminal_id`, `mode_id`)" +
                       "VALUES(?, ?, ?, ?, ?, ?)";

        // 使用 JdbcTemplate 的 update 方法執行 SQL 語句
        int rowsAffected = jdbcTemplate.update(sql, taskNumber, creatTime, agv, start, terminal, mode);
        return (rowsAffected > 0);
    }
    
    public boolean insertTaskNoStart(String taskNumber, String creatTime, String agv, String terminal,String mode){
        String sql = "INSERT INTO `task_history`(`task_number`, `create_task_time`, `agv_id`, `terminal_id`, `mode_id`)" +
                       "VALUES(?, ?, ?, ?, ?)";

        // 使用 JdbcTemplate 的 update 方法執行 SQL 語句
        int rowsAffected = jdbcTemplate.update(sql, taskNumber, creatTime, agv, terminal, mode);
        return (rowsAffected > 0);
    }
    
    public boolean updateTaskStatus(String taskNumber, int status){
        String sql = "UPDATE `task_history` SET `status` = ? WHERE (`task_number` = ?)";
        int rowsAffected = jdbcTemplate.update(sql, status, taskNumber);
        return (rowsAffected > 0);
    }
    
    public boolean cancelTask(String taskNumber){
        String sql = "UPDATE `task_history` SET `status` = '-1' WHERE (`task_number` = ?);";
        // 使用 JdbcTemplate 的 update 方法執行 SQL 語句
        int rowsAffected = jdbcTemplate.update(sql, taskNumber);
        return (rowsAffected > 0);
    }
}
