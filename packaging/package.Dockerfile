FROM alpine:3.15

WORKDIR /
RUN mkdir /home/ondewo_monitoring
RUN mkdir /home/export

COPY alertmanager /home/ondewo_monitoring/alertmanager
COPY caddy /home/ondewo_monitoring/caddy
COPY grafana /home/ondewo_monitoring/grafana
COPY helpers /home/ondewo_monitoring/helpers
COPY prometheus /home/ondewo_monitoring/prometheus
COPY screens /home/ondewo_monitoring/screens
COPY config /home/ondewo_monitoring/
COPY docker-compose.yml /home/ondewo_monitoring/
COPY docker-compose.exporters.yml /home/ondewo_monitoring/
COPY README.md /home/ondewo_monitoring/
COPY LICENSE /home/ondewo_monitoring/

LABEL \
      org.label-schema.name="Ondewo Monitoring System" \
      org.label-schema.description="Ondewo Monitoring System based on DockProm https://github.com/stefanprodan/dockprom" \
      org.label-schema.version=${VERSION} \
      org.label-schema.vcs-url="https://github.com/ondewo/ondewo-monitoring"

CMD cp -r /home/ondewo_monitoring /home/export && echo 'Ondewo Monitoring installed successfully!'
