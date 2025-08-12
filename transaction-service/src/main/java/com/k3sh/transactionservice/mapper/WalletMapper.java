package com.k3sh.transactionservice.mapper;

import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;

import com.k3sh.common.model.CreateWalletRequest;
import com.k3sh.common.model.WalletResponse;
import com.k3sh.transactionservice.entity.Wallet;

import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface WalletMapper {
    Wallet toEntity(CreateWalletRequest dto);

    WalletResponse toDto(Wallet entity);

    default OffsetDateTime map(LocalDateTime localDateTime) {
        return localDateTime != null ? localDateTime.atOffset(ZoneOffset.UTC) : null;
    }
}
