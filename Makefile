#################################
# Application workflow
#################################

SERVICES=nginx mysql workspace

# Mount dev volumes and port forwarding for development
docker-compose-dev.yml: docker-compose.yml dc-dev.yml
	yq merge docker-compose.yml dc-dev.yml > docker-compose-dev.yml

# Run all containers
.PHONY: up
up: docker-compose-dev.yml
	@docker-compose -f docker-compose-dev.yml up -d ${SERVICES}

# Stop all containers
.PHONY: down
down:
	@docker-compose -f docker-compose-dev.yml down

# Rebuild
.PHONY: rebuild
rebuild: docker-compose-dev.yml
	@docker-compose -f docker-compose-dev.yml up -d --build ${SERVICES}

# Test
.PHONY: test
test: up docker-compose-dev.yml
#	@docker-compose -f docker-compose-dev.yml up --build test
	@docker-compose -f docker-compose-dev.yml up test

# Restart
.PHONY: restart
restart: down up

# Reload all services
.PHONY: reload
reload: nginx-reload

# Nginx reload
.PHONY: nginx-reload
nginx-reload:
	@docker-compose exec nginx sh -c 'nginx -s reload'

# Php reload
.PHONY: php-reload
php-reload:
	@docker-compose exec php-fpm sh -c 'kill 1'

#################################
# Test & debug
#################################

# Nginx reload
.PHONY: workspace
workspace:
	@docker-compose exec --user=laradock workspace zsh

# Healthcheck
.PHONY: nginx-healthcheck
nginx-healthcheck: up
	@docker-compose exec nginx sh -c 'curl -v http://localhost/healthcheck'
