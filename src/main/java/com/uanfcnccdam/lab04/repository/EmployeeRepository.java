package com.uanfcnccdam.lab04.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.uanfcnccdam.lab04.model.Employee;

public interface EmployeeRepository extends JpaRepository<Employee, Long>{


	Employee findByEmployeeId(long employeeId);

}
