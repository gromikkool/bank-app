
SERVICES := individuals-api person-service

up:
		@for %%s in ($(SERVICES)) do ( \
    		cd %%s && docker-compose up -d --build \
    	)

down:
	@for service in $(SERVICES); do \
		docker-compose -f $$service/docker-compose.yml down; \
	done

logs:
	@for service in $(SERVICES); do \
		echo "=== Logs: $$service ==="; \
		docker-compose -f $$service/docker-compose.yml logs --tail=20; \
	done

restart: down up

up-service:
	docker-compose -f $(SERVICE)/docker-compose.yml up -d --build

down-service:
	docker-compose -f $(SERVICE)/docker-compose.yml down

logs-service:
	docker-compose -f $(SERVICE)/docker-compose.yml logs --tail=20

.PHONY: up down logs restart up-service down-service logs-service


# Поднять Nexus
nexus-up:
	docker-compose -f docker-compose.nexus.yml up -d --build

# Остановить Nexus
nexus-down:
	docker-compose -f docker-compose.nexus.yml down

# Логи Nexus
nexus-logs:
	docker-compose -f docker-compose.nexus.yml logs -f

# Открыть Nexus в браузере (Linux/macOS only)
nexus-open:
	xdg-open http://localhost:8081 || open http://localhost:8081

publish-module:
	docker run --rm \
	  --network=shared_net \
	  -v $(CURDIR)/person-service/person-service-client:/home/gradle/project \
	  -w /home/gradle/project \
	  gradle:8.5-jdk21 \
	  gradle publish \
	    -PnexusUrl=http://nexus:8081/repository/maven-releases \
	    -PnexusUser=admin -PnexusPassword=3717grom