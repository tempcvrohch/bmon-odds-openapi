#!/bin/bash

set -e

rm -rf out/typescript

docker run --rm \
	-v "${PWD}:/local" \
	openapitools/openapi-generator-cli generate \
	-i /local/bmon-odds.yaml \
	-c /local/config-typescript.yaml \
	--ignore-file-override /local/.openapi-generator-ignore \
	-g typescript-fetch \
	-o /local/out/typescript