#!/bin/bash

set -e

rm -rf out/csharp

docker run --rm \
	-v "${PWD}:/local" \
	openapitools/openapi-generator-cli generate \
	-i /local/bmon-odds.yaml \
	-c /local/config-csharp.yaml \
	--ignore-file-override /local/.openapi-generator-ignore \
	-g csharp \
	-o /local/out/csharp