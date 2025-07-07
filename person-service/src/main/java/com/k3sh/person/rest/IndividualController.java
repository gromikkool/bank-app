package com.k3sh.person.rest;

import com.k3sh.common.model.IndividualCreateDto;
import com.k3sh.common.model.IndividualDto;
import com.k3sh.person.api.IndividualsApi;
import com.k3sh.person.service.IndividualService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.UUID;

@RestController
@AllArgsConstructor
public class IndividualController implements IndividualsApi {

     private final IndividualService individualService;

     @Override
     public ResponseEntity<IndividualDto> getIndividualByEmail(String email) {
          IndividualDto individualDto = individualService.getIndividualByEmail(email);
          return ResponseEntity.ok(individualDto);
     }

     @Override
     public ResponseEntity<List<IndividualDto>> getAllIndividuals() {
          return ResponseEntity.ok(individualService.getAllIndividuals());
     }

     @Override
     public ResponseEntity<IndividualDto> getIndividualById(String id) {
          return ResponseEntity.ok(individualService.getIndividualById(id));
     }

     @Override
     public ResponseEntity<IndividualDto> createIndividual(IndividualCreateDto individualCreateDto) {
          return ResponseEntity.ok(individualService.createIndividual(individualCreateDto));
     }

     @Override
     public ResponseEntity<IndividualDto> deleteIndividual(UUID id) {
          IndividualDto deletedUser = individualService.deleteIndividual(id);
          return ResponseEntity.ok(deletedUser);
     }

}
