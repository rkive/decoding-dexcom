#!/usr/bin/env bash
#
# This expects your NewRelic Insights secrets to be exported to your environment.

python ./dxcom-records-cgm

if [ $? = 0 ]; then
  cat logs/cgm_metrics.json | curl -d @- -X POST \
    -H "Content-Type: application/json" \
    -H "X-Insert-Key: ${INSIGHTS_INSERT_KEY}" \
    https://insights.newrelic.com/beta_api/accounts/${INSIGHTS_ACCOUNT_ID}/events
fi
