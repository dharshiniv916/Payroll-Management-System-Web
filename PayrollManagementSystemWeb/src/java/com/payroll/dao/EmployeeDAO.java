package com.payroll.dao;

import java.sql.*;
import com.payroll.util.DBConnection;

public class EmployeeDAO {

    public boolean saveEmployee(
        String code,
        String name,
        String gender,
        String dept,
        String desig,
        String email,
        String phone,
        double salary,
        String joinDate){

        boolean status=false;

        try{

            Connection con=DBConnection.getConnection();

            String sql="INSERT INTO employee(emp_code,name,gender,department,designation,email,phone,basic_salary,join_date) VALUES(?,?,?,?,?,?,?,?,?)";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setString(1,code);
            ps.setString(2,name);
            ps.setString(3,gender);
            ps.setString(4,dept);
            ps.setString(5,desig);
            ps.setString(6,email);
            ps.setString(7,phone);
            ps.setDouble(8,salary);
            ps.setString(9,joinDate);

            int i=ps.executeUpdate();

            if(i>0)
                status=true;

        }catch(Exception e){

            e.printStackTrace();

        }

        return status;

    }

}