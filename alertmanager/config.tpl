templates:
  - 'telegram.tpl'

receivers:
- name: 'telegram'
  telegram_configs:
  - chat_id: ${CHANNEL}
    bot_token: ${TOKEN}
    send_resolved: true  # Optional: Send notifications when alerts resolve
    parse_mode: 'Markdown'
    message: '{{ template "telegram.message" . }}'

route:
  receiver: 'telegram'
  group_by: ['alertname']  # Group alerts by alertname
  group_wait: 30s  # Time to wait to group alerts
  group_interval: 5m  # Time to wait before sending a new notification
  repeat_interval: 3h  # Time to wait before resending the same notification
  routes:
  - match:
      severity: critical
    receiver: 'telegram'
