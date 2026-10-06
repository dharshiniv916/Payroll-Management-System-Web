
package com.payroll.entity;


public class Salary {
    
    private int salaryId;
    private int empId;
    private String salaryMonth;
    private int overtimeHours;
    private double bonus;
    private double grossSalary;
    private double netSalary;

    public Salary() {}

    public int getSalaryId() { return salaryId; }
    public void setSalaryId(int salaryId) { this.salaryId = salaryId; }

    public int getEmpId() { return empId; }
    public void setEmpId(int empId) { this.empId = empId; }

    public String getSalaryMonth() { return salaryMonth; }
    public void setSalaryMonth(String salaryMonth) {
        this.salaryMonth = salaryMonth;
    }

    public int getOvertimeHours() { return overtimeHours; }
    public void setOvertimeHours(int overtimeHours) {
        this.overtimeHours = overtimeHours;
    }

    public double getBonus() { return bonus; }
    public void setBonus(double bonus) { this.bonus = bonus; }

    public double getGrossSalary() { return grossSalary; }
    public void setGrossSalary(double grossSalary) {
        this.grossSalary = grossSalary;
    }

    public double getNetSalary() { return netSalary; }
    public void setNetSalary(double netSalary) {
        this.netSalary = netSalary;
    }
}
