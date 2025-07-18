package com.k3sh.person;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.UUID;

import javax.sql.DataSource;

import org.jetbrains.annotations.NotNull;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.k3sh.common.model.AddressCreateDto;
import com.k3sh.common.model.IndividualCreateDto;
import com.k3sh.common.model.IndividualDto;
import com.k3sh.common.model.UserCreateDto;

@Testcontainers
@ActiveProfiles("test")
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureMockMvc
public class IntegrationTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private DataSource dataSource;

    @Autowired
    private ObjectMapper objectMapper;

    @Container
    private static final PostgreSQLContainer<?> personServicePostgre = new PostgreSQLContainer<>("postgres:15")
            .withDatabaseName("person")
            .withUsername("test")
            .withPassword("test")
            .withNetworkAliases("postgres")
            .withReuse(false);

    @DynamicPropertySource
    static void configureProperties(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", personServicePostgre::getJdbcUrl);
        registry.add("spring.datasource.username", personServicePostgre::getUsername);
        registry.add("spring.datasource.password", personServicePostgre::getPassword);
        registry.add("spring.flyway.url", personServicePostgre::getJdbcUrl);
        registry.add("spring.flyway.user", personServicePostgre::getUsername);
        registry.add("spring.flyway.password", personServicePostgre::getPassword);

    }

    @Test
    void containerIsRunning() {
        Assertions.assertTrue(personServicePostgre.isRunning());
    }

    @Test
    void flywayMigrationsAreApplied() throws Exception {
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM person.flyway_schema_history");
             ResultSet rs = stmt.executeQuery()) {

            Assertions.assertTrue(rs.next(), "No rows in flyway_schema_history");
            int count = rs.getInt(1);
            Assertions.assertTrue(count > 0, "No Flyway migrations applied");
        }
    }

    @Test
    void createIndividualTest() throws Exception {
        IndividualCreateDto createDto = getIndividualCreateDto("test@example.com");

        String content = objectMapper.writeValueAsString(createDto);

        mockMvc.perform(post("/individuals")
                .contentType(MediaType.APPLICATION_JSON).content(content).accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());
    }

    @NotNull
    private static IndividualCreateDto getIndividualCreateDto(String email) {
        // Given
        IndividualCreateDto createDto = new IndividualCreateDto();

        UserCreateDto userDto = new UserCreateDto();
        AddressCreateDto addressDto = new AddressCreateDto();
        addressDto.setCountryAlpha2("US");
        userDto.setAddress(addressDto);
        userDto.setEmail(email);
        createDto.setUser(userDto);
        return createDto;
    }

    @Test
    void getIndividualByIdTest() throws Exception {
        // Given
        IndividualCreateDto individualCreateDto = getIndividualCreateDto("test1@example.com");
        String content = objectMapper.writeValueAsString(individualCreateDto);

        // When
        MvcResult mvcResult = mockMvc.perform(post("/individuals").contentType(MediaType.APPLICATION_JSON)
                .content(content)
                .accept(MediaType.APPLICATION_JSON)).andExpect(status().isOk()).andReturn();

        IndividualDto individualDto = objectMapper.readValue(mvcResult.getResponse().getContentAsString(), IndividualDto.class);
        UUID uuid = individualDto.getId();

        // Then
        mockMvc.perform(get("/individuals/" + uuid)
                .contentType(MediaType.APPLICATION_JSON).accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());
    }

    @Test
    void deleteIndividualTest() throws Exception {
        // Given
        IndividualCreateDto individualCreateDto = getIndividualCreateDto("test12@example.com");
        String content = objectMapper.writeValueAsString(individualCreateDto);

        // When
        MvcResult mvcResult = mockMvc.perform(post("/individuals").contentType(MediaType.APPLICATION_JSON)
                .content(content)
                .accept(MediaType.APPLICATION_JSON)).andExpect(status().isOk()).andReturn();

        IndividualDto individualDto = objectMapper.readValue(mvcResult.getResponse().getContentAsString(), IndividualDto.class);
        UUID uuid = individualDto.getId();

        // Then
        mockMvc.perform(delete("/individuals/" + uuid)
                .contentType(MediaType.APPLICATION_JSON).accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());
    }

}
