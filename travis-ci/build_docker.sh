#!/usr/bin/env bash
# this one needs to be bash since we are using [[ ]]

REPO=steinwaywhw/ats

docker build -f Dockerfile -t $REPO:$TRAVIS_COMMIT --build-arg ATSVER=${ATSVER} ./

if [[ "$TRAVIS_BRANCH" == "master" ]]; then 
	if [ -z "$TRAVIS_TAG" ]; then 
		echo "$REPO:git"
		docker tag $REPO:$TRAVIS_COMMIT $REPO:git                 # steinwaywhw/ats:git
	else 
		echo "$REPO:$TRAVIS_TAG"
		docker tag $REPO:$TRAVIS_COMMIT $REPO:$TRAVIS_TAG         # steinwaywhw/ats:1.0
		echo "$REPO:latest"
		docker tag $REPO:$TRAVIS_COMMIT $REPO:latest              # steinwaywhw/ats:latest
	fi
else
	echo "$REPO:$TRAVIS_BRANCH"
	docker tag $REPO:$TRAVIS_COMMIT $REPO:$TRAVIS_BRANCH          # steinwaywhw/ats:branch
fi

docker push $REPO


