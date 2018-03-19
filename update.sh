#!/bin/bash

IMAGE=sturai/ilias-dev

build_ilias() {
    ilias_version=$1
    base=$2

    docker build --rm \
        -t ${IMAGE}:${ilias_version} \
        -t ${IMAGE}:${ilias_version}-${base} \
        ${ilias_version}/${base}
}

for d in */*; do
    version=$(basename $(dirname $d))
    base=$(basename $d)
    build_ilias $version $base
done

docker tag ${IMAGE}:$version ${IMAGE}:latest
