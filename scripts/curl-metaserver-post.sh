#!/bin/bash

curl -X POST http://cf-metaserver.cf.real-time.com/meta_update.php \
     -d "hostname=localhost" \
     -d "port=8080" \
     -d "html_comment=This is an HTML comment" \
     -d "text_comment=This is a text comment" \
     -d "archbase=Archetypes base description" \
     -d "mapbase=Maps base description" \
     -d "codebase=Server code base description" \
     -d "flags=abc" \
     -d "num_players=100" \
     -d "in_bytes=1024" \
     -d "out_bytes=2048" \
     -d "uptime=3600" \
     -d "version=1.0.0" \
     -d "sc_version=2.0.0" \
     -d "cs_version=2.0.0"
