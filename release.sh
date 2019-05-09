#!/usr/bin/env bash
set -e

. build.sh

scream "Pushing images"
push_app

