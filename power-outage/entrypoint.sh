#!/usr/bin/env bash

exec /usr/local/bin/webhook -nopanic -debug -hooks /app/hooks.json
