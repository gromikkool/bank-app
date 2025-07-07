package com.k3sh.person.repository;

import com.k3sh.person.entity.Country;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CountryRepository extends JpaRepository<Country, Long> {
     Optional<Country> findByAlpha2(String alpha2);
     Optional<Country> findByAlpha3(String alpha3);
}
