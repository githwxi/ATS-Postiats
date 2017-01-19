#!/usr/bin/env bash
# this one needs to be bash since we are using [[ ]]

REPO=steinwaywhw/ats

docker build -f Dockerfile -t $REPO:$TRAVIS_COMMIT --build-arg ATSVER=${ATSVER} ./

if [[ "$TRAVIS_BRANCH" == "master" ]]; then 
	if [ -z "$TRAVIS_TAG" ]; then 
		docker tag $REPO:$TRAVIS_COMMIT $REPO:git                 # steinwaywhw/ats:git
	else 
		docker tag $REPO:$TRAVIS_COMMIT $REPO:$TRAVIS_TAG         # steinwaywhw/ats:1.0
		docker tag $REPO:$TRAVIS_COMMIT $REPO:latest              # steinwaywhw/ats:latest
	fi
else
	docker tag $REPO:$TRAVIS_COMMIT $REPO:$TRAVIS_BRANCH          # steinwaywhw/ats:branch
fi

docker push $REPO


