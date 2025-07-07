package com.k3sh.person.repository;

import com.k3sh.person.entity.User;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface UserRepository extends CrudRepository<User, UUID> {
     @EntityGraph(value = "userGraph")
     Optional<User> findById(UUID id);

     Optional<User> findByEmail(String email);
}
