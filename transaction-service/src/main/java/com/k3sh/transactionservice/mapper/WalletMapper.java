package com.k3sh.transactionservice.mapper;

import com.k3sh.common.model.CreateWalletRequest;
import com.k3sh.common.model.WalletResponse;
import com.k3sh.transactionservice.entity.Wallet;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface WalletMapper  {
     Wallet toEntity(CreateWalletRequest dto);

     WalletResponse toDto(Wallet entity);
}
