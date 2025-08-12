val openApiGeneratorVersion: String by project
val javaxAnnotationApiVersion: String by project
val springCoreVersion: String by project
val jakartaValidationApiVersion: String by project
val jacksonDatabindNullableVersion: String by project
val swaggerAnnotationsVersion: String by project
val jacksonDatabindVersion: String by project
val jakartaAnnotationApiVersion: String by project
val springVersion: String by project
val jakartaServletApiVersion: String by project

plugins {
    java
    id("org.springframework.boot") version "3.5.4"
    id("io.spring.dependency-management") version "1.1.7"
    id("org.openapi.generator") version "7.14.0"
    id("maven-publish")
}



group = "com.k3sh"
version = "1.0.0-SNAPSHOT"

val openApiOutputDir = layout.buildDirectory.dir("generated-sources/openapi").get().asFile

openApiGenerate {
    generatorName = "spring"
    inputSpec = "$rootDir/openapi/transaction-service.yaml"
    outputDir = openApiOutputDir.absolutePath
    modelPackage = "com.k3sh.common.model"
    apiPackage = "com.k3sh.common.api"
    generateApiDocumentation = false
    skipOperationExample = true
    generateModelTests = false
    generateModelDocumentation = false
    configOptions = mapOf(
        "library" to "spring-boot",
        "interfaceOnly" to "true",
        "useSpringBoot3" to "true",
        "openApiNullable" to "false",
        "skipDefaultInterface" to "true",
        "skipDefaultExample" to "true"
    )
}

publishing {
    publications {
        create<MavenPublication>("maven") {
            println("Publishing version: ${project.version}")
            groupId = project.group as String
            artifactId = "transaction-service-client"
            version = project.version as String
            from(components["java"])

        }
    }

    repositories {
        maven {
            name = "LocalNexus"
            url = uri(System.getenv("NEXUS_URL") ?: "http://localhost:8081/repository/maven-snapshots/")

            credentials {
                username = System.getenv("NEXUS_USERNAME") ?: "admin"
                password = System.getenv("NEXUS_PASSWORD") ?: "3717grom"
            }

            isAllowInsecureProtocol = true
        }
    }
}


java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(21)
    }
}

sourceSets {
    main {
        java {
            srcDir("$openApiOutputDir/src/main/java")
        }
    }
}
repositories {
    mavenCentral()
}

dependencies {
    implementation("org.springframework.boot:spring-boot-starter")
    implementation("org.springframework:spring-web:${springVersion}")
    testImplementation("org.springframework.boot:spring-boot-starter-test")
    testRuntimeOnly("org.junit.platform:junit-platform-launcher")
    compileOnly("javax.annotation:javax.annotation-api:$javaxAnnotationApiVersion")
    compileOnly("org.springframework:spring-core:${springCoreVersion}")
    compileOnly("jakarta.validation:jakarta.validation-api:${jakartaValidationApiVersion}")
    compileOnly("org.openapitools:jackson-databind-nullable:${jacksonDatabindNullableVersion}")
    compileOnly("io.swagger.core.v3:swagger-annotations:${swaggerAnnotationsVersion}")
    compileOnly("com.fasterxml.jackson.core:jackson-databind:${jacksonDatabindVersion}")
    compileOnly("jakarta.annotation:jakarta.annotation-api:${jakartaAnnotationApiVersion}")
    compileOnly("org.springframework:spring-context:${springVersion}")
    compileOnly("jakarta.servlet:jakarta.servlet-api:${jakartaServletApiVersion}")
}

tasks.named("compileJava") {
    dependsOn("openApiGenerate")
}
