package com.k3sh.person.service;


import com.k3sh.common.model.IndividualCreateDto;
import com.k3sh.common.model.IndividualDto;

import java.util.List;
import java.util.UUID;

public interface IndividualService {
     List<IndividualDto> getAllIndividuals();

     IndividualDto getIndividualById(String id);

     IndividualDto createIndividual(IndividualCreateDto userCreateDto);

     IndividualDto deleteIndividual(UUID id);

     IndividualDto getIndividualByEmail(String email);
}
