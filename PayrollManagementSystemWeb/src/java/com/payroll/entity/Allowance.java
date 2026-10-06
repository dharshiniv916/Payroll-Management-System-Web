
package com.payroll.entity;

public class Allowance {
    
      private int allowanceId;
    private int empId;
    private double hra;
    private double da;
    private double travel;
    private double medical;

    public Allowance() {}

    public int getAllowanceId() { return allowanceId; }
    public void setAllowanceId(int allowanceId) {
        this.allowanceId = allowanceId;
    }

    public int getEmpId() { return empId; }
    public void setEmpId(int empId) { this.empId = empId; }

    public double getHra() { return hra; }
    public void setHra(double hra) { this.hra = hra; }

    public double getDa() { return da; }
    public void setDa(double da) { this.da = da; }

    public double getTravel() { return travel; }
    public void setTravel(double travel) { this.travel = travel; }

    public double getMedical() { return medical; }
    public void setMedical(double medical) { this.medical = medical; }
}
