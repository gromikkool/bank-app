package com.k3sh.person.service;

import com.k3sh.person.entity.Country;

import java.util.List;
import java.util.Optional;

public interface CountryService {
     List<Country> getAllCountries();

     Optional<Country> getCountryByAlpha2orAlpha3(String alpha2, String alpha3);
}
