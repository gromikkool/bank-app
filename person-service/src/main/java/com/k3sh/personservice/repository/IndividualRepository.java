package com.k3sh.personservice.repository;

import com.k3sh.personservice.entity.Individual;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface IndividualRepository extends JpaRepository<Individual, UUID> {
}
