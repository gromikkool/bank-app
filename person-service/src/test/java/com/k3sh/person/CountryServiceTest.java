package com.k3sh.person;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import com.k3sh.person.entity.Country;
import com.k3sh.person.repository.CountryRepository;
import com.k3sh.person.service.CountryService;
import com.k3sh.person.service.implementation.CountryServiceImpl;

class CountryServiceTest {

     CountryService countryService;

     @Mock
     CountryRepository countryRepository;

     @BeforeEach
     void setUp() {
          MockitoAnnotations.openMocks(this);
          countryService = new CountryServiceImpl(countryRepository);
     }

     @Test
     void shouldReturnAllCountries() {
          // Given
          Country country1 = new Country();
          country1.setAlpha2("US");
          Country country2 = new Country();
          country2.setAlpha2("FR");

          List<Country> expectedCountries = List.of(country1, country2);
          when(countryRepository.findAll()).thenReturn(expectedCountries);

          // When
          List<Country> result = countryService.getAllCountries();

          // Then
          assertEquals(2, result.size());
          assertEquals("US", result.get(0).getAlpha2());
          assertEquals("FR", result.get(1).getAlpha2());
          verify(countryRepository).findAll();
     }

     @Test
     void shouldReturnCountryByAlpha2() {
          // Given
          Country country = new Country();
          country.setAlpha2("US");

          when(countryRepository.findByAlpha2("US")).thenReturn(Optional.of(country));

          // When
          Optional<Country> result = countryService.getCountryByAlpha2orAlpha3("US", null);

          // Then
          assertTrue(result.isPresent());
          assertEquals("US", result.get().getAlpha2());
          verify(countryRepository).findByAlpha2("US");
          verifyNoMoreInteractions(countryRepository);
     }

     @Test
     void shouldReturnCountryByAlpha3WhenAlpha2IsNull() {
          // Given
          Country country = new Country();
          country.setAlpha3("USA");

          when(countryRepository.findByAlpha3("USA")).thenReturn(Optional.of(country));

          // When
          Optional<Country> result = countryService.getCountryByAlpha2orAlpha3(null, "USA");

          // Then
          assertTrue(result.isPresent());
          assertEquals("USA", result.get().getAlpha3());
          verify(countryRepository).findByAlpha3("USA");
          verifyNoMoreInteractions(countryRepository);
     }

     @Test
     void shouldReturnEmptyWhenBothCodesAreNull() {
          // When
          Optional<Country> result = countryService.getCountryByAlpha2orAlpha3(null, null);

          // Then
          assertTrue(result.isEmpty());
          verifyNoInteractions(countryRepository);
     }

     @Test
     void shouldReturnEmptyWhenCountryNotFound() {
          // Given
          when(countryRepository.findByAlpha2("US")).thenReturn(Optional.empty());
          when(countryRepository.findByAlpha3("USA")).thenReturn(Optional.empty());

          // When
          Optional<Country> result = countryService.getCountryByAlpha2orAlpha3("US", "USA");

          // Then
          assertTrue(result.isEmpty());
          verify(countryRepository).findByAlpha2("US");
          verify(countryRepository).findByAlpha3("USA");
     }
}
