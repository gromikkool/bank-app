package com.k3sh.person.service.implementation;

import com.k3sh.person.entity.Country;
import com.k3sh.person.repository.CountryRepository;
import com.k3sh.person.service.CountryService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class CountryServiceImpl implements CountryService {

     private final CountryRepository countryRepository;

     @Override
     public List<Country> getAllCountries() {
          return countryRepository.findAll();
     }

     @Override
     public Optional<Country> getCountryByAlpha2orAlpha3(String alpha2, String alpha3) {
          return Optional.ofNullable(alpha2)
                  .flatMap(countryRepository::findByAlpha2)
                  .or(() -> Optional.ofNullable(alpha3).flatMap(countryRepository::findByAlpha3));
     }
}
