package com.k3sh.transactionservice.mapper;

import com.k3sh.common.model.WalletTypeResponse;
import com.k3sh.transactionservice.entity.WalletType;
import org.mapstruct.Mapper;

import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;

@Mapper(componentModel = "spring")
public interface WalletTypeMapper {

     WalletTypeResponse toDto(WalletType entity);

     WalletType toEntity(WalletTypeResponse entity);

     default OffsetDateTime map(LocalDateTime localDateTime) {
          return localDateTime != null ? localDateTime.atOffset(ZoneOffset.UTC) : null;
     }

     default LocalDateTime map(OffsetDateTime value) {
          return value != null ? value.toLocalDateTime() : null;
     }
}
