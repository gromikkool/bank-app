package com.k3sh.person.service.implementation;

import com.k3sh.common.model.IndividualCreateDto;
import com.k3sh.common.model.IndividualDto;
import com.k3sh.person.entity.Country;
import com.k3sh.person.entity.Individual;
import com.k3sh.person.exception.CreateEntityFailed;
import com.k3sh.person.exception.UserAlreadyExists;
import com.k3sh.person.mapper.IndividualMapper;
import com.k3sh.person.repository.IndividualRepository;
import com.k3sh.person.service.CountryService;
import com.k3sh.person.service.IndividualService;
import jakarta.persistence.EntityNotFoundException;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.StreamSupport;

@Service
@AllArgsConstructor
@Slf4j
public class IndividualServiceImpl implements IndividualService {
     private final IndividualRepository individualRepository;
     private final CountryService countryService;
     private final IndividualMapper individualMapper;

     @Override
     public List<IndividualDto> getAllIndividuals() {
          Iterable<Individual> users = individualRepository.findAll();
          List<Individual> userList = StreamSupport.stream(users.spliterator(), false)
                  .toList();

          return userList.stream().map(individualMapper::toDto).toList();

     }

     @Override
     public IndividualDto getIndividualById(String id) {
          UUID uuid = UUID.fromString(id);
          return individualMapper
                  .toDto(individualRepository.findById(uuid)
                          .orElseThrow(() -> {
                               log.info("User with id {} not found", id);
                               return new EntityNotFoundException("User with id " + id + " not found");
                          }));
     }

     private boolean isUserWithEmailExists(String email) {
          return individualRepository.findByUserEmail(email).isPresent();
     }

     @Override
     @Transactional
     public IndividualDto createIndividual(IndividualCreateDto individualCreateDto) {

          if (isUserWithEmailExists(individualCreateDto.getUser().getEmail())) {
               throw new UserAlreadyExists("User with email " + individualCreateDto.getUser().getEmail() + " already exists");
          }

          String alpha2 = individualCreateDto.getUser().getAddress().getCountryAlpha2();
          String alpha3 = individualCreateDto.getUser().getAddress().getCountryAlpha3();

          Country country = countryService.getCountryByAlpha2orAlpha3(alpha2, alpha3)
                  .orElseThrow(() -> new EntityNotFoundException("Country not found: " + alpha2 + " or " + alpha3)); //todo

          try {
               Individual individual = individualMapper.toEntity(individualCreateDto, country);
               Individual savedIndividual = individualRepository.save(individual);
               return individualMapper.toDto(savedIndividual);
          } catch (DataIntegrityViolationException ex) {
               throw new CreateEntityFailed("Failed to create user", ex);
          }
     }


     @Override
     @Transactional
     public IndividualDto deleteIndividual(UUID uuid) {
          Individual user = individualRepository.findById(uuid)
                  .orElseThrow(() -> {
                       log.info("User with uuid {} not found for deletion", uuid);
                       return new EntityNotFoundException("User not found with id: " + uuid);
                  });
          individualRepository.delete(user);
          return individualMapper.toDto(user);
     }

     @Override
     public IndividualDto getIndividualByEmail(String email) {
          return individualMapper.toDto(individualRepository.findByUserEmail(email)
                  .orElseThrow(() -> {
                       log.info("User with email {} not found", email);
                       return new EntityNotFoundException("User with email " + email + " not found");
                  }));
     }
}
