package com.yiddemoroom.repository;

import com.yiddemoroom.model.Analysis;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class AnalysisDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    public List<Analysis> queryAnalysisesByAGV(Integer agvId){
        String sql = "select a.analysis_id, a.agv_id, a.year, a.month, a.day, a.week, a.working_hours, a.open_hours, a.task " +
                     "from analysis a where agv_id=? order by year, month, day";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Analysis.class), agvId);
    }
    
    public List<Analysis> queryAnalysisesRecentlyByAGV(Integer agvId){
        String sql = "select * from (select a.analysis_id, a.agv_id, a.year, a.month, a.day, a.week, a.working_hours, a.open_hours, a.task " +
                     "from analysis a where agv_id=? order by a.analysis_id DESC LIMIT 14)a order by analysis_id";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Analysis.class), agvId);
    }
    
    public List<Analysis> queryAnalysisesByAGVAndYearAndMonth(Integer agvId, Integer year, Integer month){
        String sql = "select a.analysis_id, a.agv_id, a.year, a.month, a.day, a.week, a.working_hours, a.open_hours, a.task " +
                     "from analysis a where agv_id=? and year=? and month=? order by day";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Analysis.class), agvId, year, month);
    }
    
    public List<Map<String, Object>> getAnalysisesYearsAndMonths(){
        String sql = "select DISTINCT a.year,a.month from analysis a order by year, month";
        return jdbcTemplate.queryForList(sql);
    }
}
