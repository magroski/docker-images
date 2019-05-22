#!/usr/bin/env bash
set -e

HUB_USERNAME=magroski
IMAGE_NAME="${HUB_USERNAME}/php-dev"
IMAGES_DIR='./docker/images'

scream() {
    echo
    echo
    echo "$@"
    echo
    echo
}

get_last_repo_tag() {
    # Get last annotated tag
    # https://stackoverflow.com/questions/1404796/how-to-get-the-latest-tag-name-in-current-branch-in-git
    # redirect stderr in order to avoid warnings
    echo $(git describe --tags $(git rev-list --tags --max-count=1) 2>/dev/null)
}

get_tag() {
    [[ -n "$DOCKER_TAG" ]] && echo $DOCKER_TAG || echo $(get_last_repo_tag)
}

build_app() {
    docker build --tag ${IMAGE_NAME}:cli "${IMAGES_DIR}/php-cli"
    docker tag ${IMAGE_NAME}:cli ${IMAGE_NAME}:cli-$(get_tag)
    docker build --tag ${IMAGE_NAME}:cli-phalcon "${IMAGES_DIR}/php-cli-phalcon-3.4"
    docker tag ${IMAGE_NAME}:cli-phalcon ${IMAGE_NAME}:cli-phalcon-$(get_tag)
}

push_app() {
    docker push ${IMAGE_NAME}:cli
    docker push ${IMAGE_NAME}:cli-$(get_tag)
    docker push ${IMAGE_NAME}:cli-phalcon
    docker push ${IMAGE_NAME}:cli-phalcon-$(get_tag)
}

scream "Building Flux's images with tag $(get_tag)"
build_app
