#!/bin/bash
rm -rf out/
docker run --rm -v "${PWD}:/local" bmon-odds-openapi:latest