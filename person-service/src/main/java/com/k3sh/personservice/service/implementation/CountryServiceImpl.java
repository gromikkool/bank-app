package com.k3sh.personservice.service.implementation;

import com.k3sh.personservice.entity.Country;
import com.k3sh.personservice.repository.CountryRepository;
import com.k3sh.personservice.service.CountryService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class CountryServiceImpl implements CountryService {

     private final CountryRepository countryRepository;

     @Override
     public List<Country> getAllCountries() {
          return countryRepository.findAll();
     }
}
