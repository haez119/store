package com.min.store.config;

import java.sql.SQLException;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import oracle.jdbc.pool.OracleDataSource;

@Configuration
@EnableTransactionManagement
public class DBConfiguration {
    final static String DB_URL="jdbc:oracle:thin:@timetable_high?TNS_ADMIN=C://Users//timetable";
    final static String DB_USER = "admin";
    final static String DB_PASSWORD = "DHrkawk123123";
    
   //데이터소스 등록
   @Bean(destroyMethod="close")
   public OracleDataSource dataSource() throws SQLException {
      OracleDataSource dataSource = new OracleDataSource();
      dataSource.setDriverType("oracle.jdbc.OracleDriver");
      dataSource.setURL(DB_URL);
      dataSource.setUser(DB_USER);
      dataSource.setPassword(DB_PASSWORD);
      return dataSource;
   }
   // 트랜잭션 매니저 등록    
    @Bean
    public DataSourceTransactionManager transactionManager() throws SQLException {
        return new DataSourceTransactionManager(dataSource());
    }
}