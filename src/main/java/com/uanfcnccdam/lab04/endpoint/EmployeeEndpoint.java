package com.uanfcnccdam.lab04.endpoint;

import javax.xml.namespace.QName;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ws.server.endpoint.annotation.Endpoint;
import org.springframework.ws.server.endpoint.annotation.PayloadRoot;
import org.springframework.ws.server.endpoint.annotation.RequestPayload;
import org.springframework.ws.server.endpoint.annotation.ResponsePayload;

import com.uanfcnccdam.lab04.model.Employee;
import com.uanfcnccdam.lab04.services.EmployeeServices;

import allapis.springbootsoap.com.AddEmployeeRequest;
import allapis.springbootsoap.com.AddEmployeeResponse;
import allapis.springbootsoap.com.DeleteEmployeeRequest;
import allapis.springbootsoap.com.DeleteEmployeeResponse;
import allapis.springbootsoap.com.EmployeeInfo;
import allapis.springbootsoap.com.GetEmployeeByIdRequest;
import allapis.springbootsoap.com.GetEmployeeResponse;
import allapis.springbootsoap.com.ServiceStatus;
import allapis.springbootsoap.com.UpdateEmployeeRequest;
import allapis.springbootsoap.com.UpdateEmployeeResponse;
import jakarta.xml.bind.JAXBElement;

@Endpoint
public class EmployeeEndpoint {

	private static final String NAMESPACE_URI = "http://com.springbootsoap.allapis";

	@Autowired
	private EmployeeServices employeeService;

	@PayloadRoot(namespace = NAMESPACE_URI, localPart = "addEmployeeRequest")
	@ResponsePayload
	public JAXBElement<AddEmployeeResponse> addEmployee(@RequestPayload JAXBElement<AddEmployeeRequest> request) {
		AddEmployeeResponse response = new AddEmployeeResponse();
		ServiceStatus serviceStatus = new ServiceStatus();

		Employee employee = new Employee();
		BeanUtils.copyProperties(request.getValue().getEmployeeInfo(), employee);
		employeeService.AddEmployee(employee);
		serviceStatus.setStatus("SUCCESS");
		serviceStatus.setMessage("Content Added Successfully");
		response.setServiceStatus(serviceStatus);
		QName qName = new QName("AddEmployeeRequest");
		JAXBElement<AddEmployeeResponse> jaxbElement = new JAXBElement<AddEmployeeResponse>( qName, AddEmployeeResponse.class, response);
		return jaxbElement;
	}

	@PayloadRoot(namespace = NAMESPACE_URI, localPart = "getEmployeeByIdRequest")
	@ResponsePayload
	public JAXBElement<GetEmployeeResponse> getEmployee(@RequestPayload JAXBElement<GetEmployeeByIdRequest> request) {
		GetEmployeeResponse response = new GetEmployeeResponse();
		EmployeeInfo employeeInfo = new EmployeeInfo();
		BeanUtils.copyProperties(employeeService.getEmployeeById(request.getValue().getEmployeeId()), employeeInfo);
		response.setEmployeeInfo(employeeInfo);
		QName qName = new QName("GetEmployeeResponse");
		JAXBElement<GetEmployeeResponse> jaxbElement = new JAXBElement<GetEmployeeResponse>( qName, GetEmployeeResponse.class, response);
		return jaxbElement;
	}

	@PayloadRoot(namespace = NAMESPACE_URI, localPart = "updateEmployeeRequest")
	@ResponsePayload
	public JAXBElement<UpdateEmployeeResponse> updateEmployee(@RequestPayload JAXBElement<UpdateEmployeeRequest> request) {
		Employee employee = new Employee();
		BeanUtils.copyProperties(request.getValue().getEmployeeInfo(), employee);
		employeeService.updateEmployee(employee);
		ServiceStatus serviceStatus = new ServiceStatus();
		serviceStatus.setStatus("SUCCESS");
		serviceStatus.setMessage("Content Updated Successfully");
		UpdateEmployeeResponse response = new UpdateEmployeeResponse();
		response.setServiceStatus(serviceStatus);
		QName qName = new QName("UpdateEmployeeResponse");
		JAXBElement<UpdateEmployeeResponse> jaxbElement = new JAXBElement<UpdateEmployeeResponse>( qName, UpdateEmployeeResponse.class, response);
		return jaxbElement;
	}

	@PayloadRoot(namespace = NAMESPACE_URI, localPart = "deleteEmployeeRequest")
	@ResponsePayload
	public JAXBElement<DeleteEmployeeResponse> deleteEmployee(@RequestPayload JAXBElement<DeleteEmployeeRequest> request) {
		employeeService.deleteEmployee(request.getValue().getEmployeeId());
		ServiceStatus serviceStatus = new ServiceStatus();

		serviceStatus.setStatus("SUCCESS");
		serviceStatus.setMessage("Content Deleted Successfully");
		DeleteEmployeeResponse response = new DeleteEmployeeResponse();
		response.setServiceStatus(serviceStatus);
		QName qName = new QName("DeleteEmployeeResponse");
		JAXBElement<DeleteEmployeeResponse> jaxbElement = new JAXBElement<DeleteEmployeeResponse>( qName, DeleteEmployeeResponse.class, response);
		return jaxbElement;
	}

}
