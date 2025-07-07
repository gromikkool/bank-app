package com.k3sh.person.repository;

import com.k3sh.person.entity.Individual;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface IndividualRepository extends JpaRepository<Individual, UUID> {

     @EntityGraph(value = "individualGraph")
     @NonNull
     Optional<Individual> findById(@NonNull UUID id);

     @EntityGraph(value = "individualGraph")
     Optional<Individual> findByUserEmail(String email);

     @EntityGraph(value = "individualGraph")
     @NonNull
     List<Individual> findAll();
}
