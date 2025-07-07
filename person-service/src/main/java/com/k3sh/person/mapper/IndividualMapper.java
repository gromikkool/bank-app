package com.k3sh.person.mapper;

import com.k3sh.common.model.IndividualCreateDto;
import com.k3sh.common.model.IndividualDto;
import com.k3sh.person.entity.Country;
import com.k3sh.person.entity.Individual;
import org.mapstruct.*;

import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface IndividualMapper {
     @Mapping(target = "user.address.archived", source = "user.address.archived")
     IndividualDto toDto(Individual user);

     @Mapping(target = "user", source = "user")
     Individual toEntity(IndividualCreateDto dto, @Context Country country);

     @AfterMapping
     default void setCountry(@MappingTarget Individual individual, IndividualCreateDto dto, @Context Country country) {
          if (individual.getUser() != null && individual.getUser().getAddress() != null) {
               individual.getUser().getAddress().setCountry(country);
          }
     }

     default OffsetDateTime map(LocalDateTime localDateTime) {
          return localDateTime != null
                  ? localDateTime.atOffset(ZoneOffset.UTC)
                  : null;
     }
}
