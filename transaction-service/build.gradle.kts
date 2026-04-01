
val mapstructVersion : String by project
val transactionServiceClientVersion : String by project

plugins {
    java
    id("org.springframework.boot") version "3.5.4"
    id("io.spring.dependency-management") version "1.1.7"
    id ("org.openapi.generator") version "7.14.0"
}

group = "com.k3sh"
version = "1.0.0-SNAPSHOT"

java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(21)
    }
}

openApiGenerate {
    generatorName.set("java")
    inputSpec.set("$rootDir/openapi/transaction-service.yaml")
    outputDir.set(layout.buildDirectory.dir("generated-sources/openapi").get().asFile.absolutePath)
    apiPackage.set("com.k3sh.transaction-service.api")
    modelPackage.set("com.k3sh.transaction-service.dto")
}


repositories {
    mavenCentral()
    maven {
        name = "ExternalRepo"

        // In Kotlin DSL, we use findProperty and cast to String
        val urlProp = findProperty("repoUrl") as String?
            ?: "http://localhost:8081/repository/maven-releases/"

        url = uri(urlProp)

        credentials {
            username = findProperty("gprUser") as String? ?: "admin"
            password = findProperty("gprKey") as String? ?: "3717grom"
        }

        // Required if your local Nexus is on HTTP (not HTTPS)
        isAllowInsecureProtocol = true
    }
}

dependencies {
    implementation("org.springframework.boot:spring-boot-starter-actuator")
    implementation("org.springframework.boot:spring-boot-starter-data-jpa")
    implementation("org.springframework.boot:spring-boot-starter-web")
    implementation("org.flywaydb:flyway-core")
    implementation("org.flywaydb:flyway-database-postgresql")
    implementation("org.springframework.kafka:spring-kafka")
    implementation("org.projectlombok:lombok")
    implementation("com.k3sh:transaction-service-client:$transactionServiceClientVersion")
    implementation("org.mapstruct:mapstruct:$mapstructVersion")
    annotationProcessor("org.mapstruct:mapstruct-processor:$mapstructVersion")
    annotationProcessor("org.projectlombok:lombok")
    runtimeOnly("io.micrometer:micrometer-registry-prometheus")
    runtimeOnly("org.postgresql:postgresql")


    testImplementation("org.springframework.boot:spring-boot-starter-test")
    testImplementation("org.springframework.boot:spring-boot-testcontainers")
    testImplementation("org.springframework.kafka:spring-kafka-test")
    testImplementation("org.testcontainers:junit-jupiter")
    testImplementation("org.testcontainers:kafka")
    testImplementation("org.testcontainers:postgresql")
    testRuntimeOnly("org.junit.platform:junit-platform-launcher")


}


tasks.withType<Test> {
    useJUnitPlatform()
}
