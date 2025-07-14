package com.k3sh.person;

import com.k3sh.common.model.*;
import com.k3sh.person.entity.Country;
import com.k3sh.person.entity.Individual;
import com.k3sh.person.exception.UserAlreadyExists;
import com.k3sh.person.mapper.IndividualMapper;
import com.k3sh.person.repository.IndividualRepository;
import com.k3sh.person.service.CountryService;
import com.k3sh.person.service.IndividualService;
import com.k3sh.person.service.implementation.IndividualServiceImpl;
import jakarta.persistence.EntityNotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class IndividualServiceTest {

     IndividualService individualService;

     @Mock
     IndividualRepository individualRepository;

     @Mock
     CountryService countryService;

     @Mock
     IndividualMapper individualMapper;

     @BeforeEach
     void init() {
          MockitoAnnotations.openMocks(this);
          individualService = new IndividualServiceImpl(individualRepository, countryService, individualMapper);
     }

     @Test
     void shouldReturnMappedIndividualDtoList() {
          // Given
          UUID uuid1 = UUID.randomUUID();
          UUID uuid2 = UUID.randomUUID();

          Individual user1 = new Individual();
          user1.setId(uuid1);
          Individual user2 = new Individual();
          user2.setId(uuid2);

          List<Individual> entities = Arrays.asList(user1, user2);
          when(individualRepository.findAll()).thenReturn(entities);

          IndividualDto dto1 = new IndividualDto();
          dto1.setId(uuid1);
          IndividualDto dto2 = new IndividualDto();
          dto2.setId(uuid2);

          when(individualMapper.toDto(user1)).thenReturn(dto1);
          when(individualMapper.toDto(user2)).thenReturn(dto2);

          // When
          List<IndividualDto> result = individualService.getAllIndividuals();

          // Then
          assertEquals(2, result.size());
          assertEquals(uuid1, result.get(0).getId());
          assertEquals(uuid2, result.get(1).getId());

          verify(individualRepository).findAll();
          verify(individualMapper).toDto(user1);
          verify(individualMapper).toDto(user2);
     }

     @Test
     void shouldReturnIndividualById() {
          UUID uuid = UUID.randomUUID();

          Individual user = new Individual();
          user.setId(uuid);

          IndividualDto dto = new IndividualDto();
          dto.setId(uuid);

          when(individualRepository.findById(uuid)).thenReturn(Optional.of(user));
          when(individualMapper.toDto(user)).thenReturn(dto);


          IndividualDto result = individualService.getIndividualById(uuid.toString());

          assertNotNull(result);
          assertEquals(uuid, result.getId());

          verify(individualRepository).findById(uuid);
          verify(individualMapper).toDto(user);
     }

     @Test
     void shouldThrowExceptionWhenIndividualNotFound() {
          // Given
          UUID uuid = UUID.randomUUID();
          String id = uuid.toString();

          when(individualRepository.findById(uuid)).thenReturn(Optional.empty());

          // When / Then
          EntityNotFoundException ex = assertThrows(EntityNotFoundException.class,
                  () -> individualService.getIndividualById(id));

          assertEquals("User with id " + id + " not found", ex.getMessage());
          verify(individualRepository).findById(uuid);
          verifyNoInteractions(individualMapper);
     }

     @Test
     void shouldCreateIndividualSuccessfully() {
          // Given
          IndividualCreateDto createDto = new IndividualCreateDto();
          IndividualDto dto = new IndividualDto();
          dto.setId(UUID.randomUUID());

          UserCreateDto userDto = new UserCreateDto();
          AddressCreateDto addressDto = new AddressCreateDto();
          addressDto.setCountryAlpha2("US");
          userDto.setAddress(addressDto);
          userDto.setEmail("test@example.com");
          createDto.setUser(userDto);

          Country country = new Country();
          country.setAlpha2("US");

          Individual entity = new Individual();
          Individual savedEntity = new Individual();
          savedEntity.setId(dto.getId());

          when(individualRepository.findByUserEmail("test@example.com")).thenReturn(Optional.empty());
          when(countryService.getCountryByAlpha2orAlpha3("US", null)).thenReturn(Optional.of(country));
          when(individualMapper.toEntity(createDto, country)).thenReturn(entity);
          when(individualRepository.save(entity)).thenReturn(savedEntity);
          when(individualMapper.toDto(savedEntity)).thenReturn(dto);

          // When
          IndividualDto result = individualService.createIndividual(createDto);

          // Then
          assertNotNull(result);
          assertEquals(dto.getId(), result.getId());
          verify(individualRepository).findByUserEmail("test@example.com");
          verify(countryService).getCountryByAlpha2orAlpha3("US", null);
          verify(individualRepository).save(entity);
     }

     @Test
     void shouldThrowWhenEmailAlreadyExists() {
          // Given
          IndividualCreateDto createDto = new IndividualCreateDto();
          UserCreateDto userDto = new UserCreateDto();
          userDto.setEmail("existing@example.com");
          createDto.setUser(userDto);

          when(individualRepository.findByUserEmail("existing@example.com")).thenReturn(Optional.of(new Individual()));

          // When / Then
          UserAlreadyExists ex = assertThrows(UserAlreadyExists.class,
                  () -> individualService.createIndividual(createDto));

          assertEquals("User with email existing@example.com already exists", ex.getMessage());
          verify(individualRepository).findByUserEmail("existing@example.com");
          verifyNoMoreInteractions(individualRepository);
     }

     @Test
     void shouldThrowWhenCountryNotFound() {
          // Given
          IndividualCreateDto createDto = new IndividualCreateDto();
          UserCreateDto userDto = new UserCreateDto();
          AddressCreateDto addressDto = new AddressCreateDto();
          addressDto.setCountryAlpha2("XX");
          userDto.setAddress(addressDto);
          userDto.setEmail("new@example.com");
          createDto.setUser(userDto);

          when(individualRepository.findByUserEmail("new@example.com")).thenReturn(Optional.empty());
          when(countryService.getCountryByAlpha2orAlpha3("XX", null)).thenReturn(Optional.empty());

          // When / Then
          EntityNotFoundException ex = assertThrows(EntityNotFoundException.class,
                  () -> individualService.createIndividual(createDto));

          assertEquals("Country not found: XX or null", ex.getMessage());
     }

     @Test
     void shouldDeleteExistingIndividual() {
          UUID id = UUID.randomUUID();

          Individual entity = new Individual();
          entity.setId(id);

          IndividualDto dto = new IndividualDto();
          dto.setId(id);

          when(individualRepository.findById(id)).thenReturn(Optional.of(entity));
          when(individualMapper.toDto(entity)).thenReturn(dto);

          IndividualDto result = individualService.deleteIndividual(id);

          assertNotNull(result);
          assertEquals(id, result.getId());

          verify(individualRepository).findById(id);
          verify(individualRepository).delete(entity);
          verify(individualMapper).toDto(entity);
     }

     @Test
     void shouldThrowWhenDeletingNonexistentIndividual() {
          UUID id = UUID.randomUUID();

          when(individualRepository.findById(id)).thenReturn(Optional.empty());

          EntityNotFoundException ex = assertThrows(EntityNotFoundException.class,
                  () -> individualService.deleteIndividual(id));

          assertEquals("User not found with id: " + id, ex.getMessage());
          verify(individualRepository).findById(id);
          verifyNoMoreInteractions(individualRepository);
     }

     @Test
     void shouldReturnIndividualByEmail() {
          String email = "found@example.com";

          Individual entity = new Individual();
          IndividualDto dto = new IndividualDto();

          when(individualRepository.findByUserEmail(email)).thenReturn(Optional.of(entity));
          when(individualMapper.toDto(entity)).thenReturn(dto);

          IndividualDto result = individualService.getIndividualByEmail(email);

          assertNotNull(result);
          verify(individualRepository).findByUserEmail(email);
          verify(individualMapper).toDto(entity);
     }

     @Test
     void shouldThrowWhenEmailNotFound() {
          String email = "missing@example.com";

          when(individualRepository.findByUserEmail(email)).thenReturn(Optional.empty());

          EntityNotFoundException ex = assertThrows(EntityNotFoundException.class,
                  () -> individualService.getIndividualByEmail(email));

          assertEquals("User with email missing@example.com not found", ex.getMessage());
          verify(individualRepository).findByUserEmail(email);
          verifyNoInteractions(individualMapper);
     }

}

