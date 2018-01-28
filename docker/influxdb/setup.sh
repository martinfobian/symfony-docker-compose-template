#!/usr/bin/env bash

# SET UP DEV DATABASE + USER
QUERY="CREATE DATABASE $INFLUXDB_DB;"
influx -username $INFLUXDB_ADMIN_USER -password $INFLUXDB_ADMIN_PASSWORD -execute "$QUERY"

QUERY="CREATE USER $INFLUXDB_USER WITH PASSWORD '$INFLUXDB_USER_PASSWORD';"
influx -username $INFLUXDB_ADMIN_USER -password $INFLUXDB_ADMIN_PASSWORD -database $INFLUXDB_DB -execute "$QUERY"

QUERY="GRANT WRITE ON $INFLUXDB_DB TO $INFLUXDB_USER;"
influx -username $INFLUXDB_ADMIN_USER -password $INFLUXDB_ADMIN_PASSWORD -database $INFLUXDB_DB -execute "$QUERY"

# SET UP TEST DATABASE + USER
QUERY="CREATE DATABASE ${INFLUXDB_DB}_test;"
influx -username $INFLUXDB_ADMIN_USER -password $INFLUXDB_ADMIN_PASSWORD -execute "$QUERY"

QUERY="CREATE USER ${INFLUXDB_USER}_test WITH PASSWORD '${INFLUXDB_USER_PASSWORD}_test';"
influx -username $INFLUXDB_ADMIN_USER -password $INFLUXDB_ADMIN_PASSWORD -database $INFLUXDB_DB -execute "$QUERY"

QUERY="GRANT WRITE ON ${INFLUXDB_DB}_test TO ${INFLUXDB_USER}_test;"
influx -username $INFLUXDB_ADMIN_USER -password $INFLUXDB_ADMIN_PASSWORD -database $INFLUXDB_DB -execute "$QUERY"



