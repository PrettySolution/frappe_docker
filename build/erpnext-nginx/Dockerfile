FROM bitnami/node:12-prod

COPY build/erpnext-nginx/install_app.sh /install_app

#RUN /install_app erpnext https://github.com/frappe/erpnext
RUN /install_app library_management https://github.com/PrettySolution/library_management.git doctypes

FROM frappe/frappe-nginx:develop

COPY --from=0 /home/frappe/frappe-bench/sites/ /var/www/html/
COPY --from=0 /rsync /rsync
RUN echo -n "\library_management" >> /var/www/html/apps.txt

VOLUME [ "/assets" ]

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
