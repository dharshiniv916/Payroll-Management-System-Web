
package com.payroll.entity;

public class Deduction {
    
    
    private int deductionId;
    private int empId;
    private double pf;
    private double tax;
    private double insurance;

    public Deduction() {}

    public int getDeductionId() { return deductionId; }
    public void setDeductionId(int deductionId) {
        this.deductionId = deductionId;
    }

    public int getEmpId() { return empId; }
    public void setEmpId(int empId) { this.empId = empId; }

    public double getPf() { return pf; }
    public void setPf(double pf) { this.pf = pf; }

    public double getTax() { return tax; }
    public void setTax(double tax) { this.tax = tax; }

    public double getInsurance() { return insurance; }
    public void setInsurance(double insurance) {
        this.insurance = insurance;
    }
}
