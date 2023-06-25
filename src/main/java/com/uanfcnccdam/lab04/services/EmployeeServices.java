package com.uanfcnccdam.lab04.services;

import com.uanfcnccdam.lab04.model.Employee;

public interface EmployeeServices {
    void AddEmployee(Employee employee);

    Employee getEmployeeById(long employeeId);

    void updateEmployee(Employee employee);

    void deleteEmployee(long employeeId);
}
