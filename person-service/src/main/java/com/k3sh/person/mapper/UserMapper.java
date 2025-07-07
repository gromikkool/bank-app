package com.k3sh.person.mapper;

import com.k3sh.common.model.UserDto;
import com.k3sh.person.entity.User;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;

import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface UserMapper {

     @Mapping(target = "address.archived", source = "address.archived")
     UserDto toDto(User user);

     default OffsetDateTime map(LocalDateTime localDateTime) {
          return localDateTime != null
                  ? localDateTime.atOffset(ZoneOffset.UTC)
                  : null;
     }
}