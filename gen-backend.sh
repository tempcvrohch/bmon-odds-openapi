#!/bin/bash

set -e

rm -rf out/spring

docker run --rm \
	-v "${PWD}:/local" \
	-e JAVA_POST_PROCESS_FILE="/usr/local/bin/clang-format -i" \
	openapitools/openapi-generator-cli generate \
	-i /local/bmon-odds.yaml \
	-c /local/config-spring.yaml \
	--ignore-file-override /local/.openapi-generator-ignore \
	-g spring \
	-o /local/out/spring