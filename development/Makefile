init:
	@sudo rm -R frappe-bench -f
	@bench init --skip-redis-config-generation --frappe-branch version-12 frappe-bench

set-config:
	@cd ./frappe-bench && \
	  bench set-mariadb-host mariadb && \
	  bench set-redis-cache-host redis-cache:6379 && \
	  bench set-redis-queue-host redis-queue:6379 && \
	  bench set-redis-socketio-host redis-socketio:6379

new-site:
	@cd ./frappe-bench && \
	  bench new-site up-server.cf --mariadb-root-password 123 --admin-password admin --no-mariadb-socket

get-erpnext:
	@cd ./frappe-bench && \
	  bench get-app --branch version-12 erpnext https://github.com/frappe/erpnext.git && \
	  bench --site up-server.cf install-app erpnext

get-library:
	@cd ./frappe-bench && \
	  bench get-app --branch master library_management https://github.com/PrettySolution/library_management && \
	  bench --site up-server.cf install-app library_management

dev_mode:
	@cd ./frappe-bench && \
	  bench  set-config developer_mode 1 -g && \
	  bench clear-cache

frappe_only: init set-config new-site dev_mode

library: init set-config new-site get-library dev_mode

erpnext: init set-config new-site get-erpnext dev_mode

drop:
	@cd ./frappe-bench && \
	  bench drop-site up-server.cf --force