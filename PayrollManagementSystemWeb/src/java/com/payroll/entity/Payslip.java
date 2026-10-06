
package com.payroll.entity;


public class Payslip {
    
    private int payslipId;
    private int empId;
    private int salaryId;
    private String generatedDate;

    public Payslip() {}

    public int getPayslipId() { return payslipId; }
    public void setPayslipId(int payslipId) {
        this.payslipId = payslipId;
    }

    public int getEmpId() { return empId; }
    public void setEmpId(int empId) { this.empId = empId; }

    public int getSalaryId() { return salaryId; }
    public void setSalaryId(int salaryId) {
        this.salaryId = salaryId;
    }

    public String getGeneratedDate() { return generatedDate; }
    public void setGeneratedDate(String generatedDate) {
        this.generatedDate = generatedDate;
    }
}
