package com.k3sh.person;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoInteractions;
import static org.mockito.Mockito.when;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import com.k3sh.common.model.IndividualDto;
import com.k3sh.person.entity.Individual;
import com.k3sh.person.mapper.IndividualMapper;
import com.k3sh.person.repository.IndividualRepository;
import com.k3sh.person.service.CountryService;
import com.k3sh.person.service.IndividualService;
import com.k3sh.person.service.implementation.IndividualServiceImpl;

import jakarta.persistence.EntityNotFoundException;

public class IndividualServiceTest {

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
}

