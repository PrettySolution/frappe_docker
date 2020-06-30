start:
	@docker-compose -f .devcontainer/docker-compose.yml up -d

restart:
	@docker-compose -f .devcontainer/docker-compose.yml stop
	@docker-compose -f .devcontainer/docker-compose.yml start

tty:
	@docker exec -e "TERM=xterm-256color" -w /workspace/development -it devcontainer_frappe_1 bash

clean:
	@docker-compose -f .devcontainer/docker-compose.yml down
	@docker volume prune -f
	@docker-compose -f .devcontainer/docker-compose.yml up -d

build-containers:
	@docker build -t containersolution/frappe-socketio:edge -f build/frappe-socketio/Dockerfile .
	@docker build -t containersolution/frappe-worker:develop -f build/frappe-worker/Dockerfile .
	@docker build -t containersolution/erpnext-worker:edge -f build/erpnext-worker/Dockerfile .
	@docker build -t containersolution/frappe-nginx:develop -f build/frappe-nginx/Dockerfile .
	@docker build -t containersolution/erpnext-nginx:edge -f build/erpnext-nginx/Dockerfile .

rebuild:
	@docker-compose down
	@docker volume prune -f
	@docker build -t containersolution/erpnext-worker:edge -f build/erpnext-worker/Dockerfile .
	@docker build -t containersolution/erpnext-nginx:edge -f build/erpnext-nginx/Dockerfile .
	@docker-compose up -d

docker-push:
	@docker push containersolution/frappe-socketio:edge
	@docker push containersolution/frappe-worker:develop
	@docker push containersolution/erpnext-worker:edge
	@docker push containersolution/frappe-nginx:develop
	@docker push containersolution/erpnext-nginx:edge