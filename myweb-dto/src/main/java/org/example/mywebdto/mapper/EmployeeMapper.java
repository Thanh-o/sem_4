package org.example.mywebdto.mapper;

import org.example.mywebdto.dto.EmployeeDto;
import org.example.mywebdto.entity.Employee;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper(componentModel = "spring")
public interface EmployeeMapper {
    EmployeeMapper INSTANCE = Mappers.getMapper(EmployeeMapper.class);

    @Mapping(target = "fullName", expression = "java(employee.getFirstName()+\" \"+employee.getLastName())")
    EmployeeDto toDto(Employee employee);//Entity to DTO

    @Mapping(target = "firstName", expression = "java(employeeDto.getFullName().split(\" \")[0])")
    @Mapping(target = "lastName", expression = "java(employeeDto.getFullName().split(\" \")[1])")
    Employee toEntity(EmployeeDto employeeDto);//DTO to Entity
}
