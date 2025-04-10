package org.example.mywebdto.service;

import org.example.mywebdto.dto.EmployeeDto;
import org.example.mywebdto.entity.Employee;
import org.example.mywebdto.mapper.EmployeeMapper;
import org.example.mywebdto.repository.EmployeeRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class EmployeeService {
    private final EmployeeRepository employeeRepository;
    private final EmployeeMapper employeeMapper;

    public EmployeeService(EmployeeRepository employeeRepository, EmployeeMapper employeeMapper) {
        this.employeeRepository = employeeRepository;
        this.employeeMapper = employeeMapper;
    }

    public EmployeeDto createEmployee(EmployeeDto employeeDto) {
        Employee employee = employeeMapper.toEntity(employeeDto);
        employee = employeeRepository.save(employee);
        return employeeMapper.toDto(employee);
    }
    public EmployeeDto getEmployeeById(Long id) {
        Employee employee = employeeRepository.findById(id).orElseThrow();
        return employeeMapper.toDto(employee);
    }
    public EmployeeDto updateEmployee(Long id, EmployeeDto employeeDto) {
        Employee employee = employeeRepository.findById(id).orElseThrow();
        String[] names= employeeDto.getFullName().split(" ");
        employee.setFirstName(names[0]);
        employee.setLastName(names[1]);
        employee.setEmail(employeeDto.getEmail());
        employeeRepository.save(employee);
        return employeeMapper.toDto(employee);
    }
    public void deleteEmployee(Long id) {
        employeeRepository.deleteById(id);
    }
    public List<EmployeeDto> getAllEmployees() {
        List<Employee> employees = employeeRepository.findAll();
        return employees.stream().map(employeeMapper::toDto).collect(Collectors.toList());
    }
}
