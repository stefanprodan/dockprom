In order to keep HASS token secret, you need to render prometheus config as follows
Make sure you export the token first with export TOKEN=<token>
Token can be found in todo.org in keepass

This will be fixed when prometheus is moved to k3s using sealed secrets

cat prometheus/prometheus.template.yml | envsubst > prometheus/prometheus.yml
