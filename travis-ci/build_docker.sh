#!/usr/bin/env bash
# this one needs to be bash since we are using [[ ]]

REPO=steinwaywhw/ats

docker build -f Dockerfile -t $REPO:$TRAVIS_COMMIT --build-arg ATSVER=${ATSVER} ./

if [[ "$TRAVIS_BRANCH" == "master" ]]; then 
	if [ -z "$TRAVIS_TAG" ]; then 
		echo "$REPO:git"
		docker tag $REPO:$TRAVIS_COMMIT $REPO:git                 # steinwaywhw/ats:git
		docker push $REPO:git
	else 
		echo "$REPO:$TRAVIS_TAG"
		docker tag $REPO:$TRAVIS_COMMIT $REPO:$TRAVIS_TAG         # steinwaywhw/ats:1.0
		docker push $REPO:$TRAVIS_TAG
		echo "$REPO:latest"
		docker tag $REPO:$TRAVIS_COMMIT $REPO:latest              # steinwaywhw/ats:latest
		docker push $REPO:latest
	fi
else
	echo "$REPO:$TRAVIS_BRANCH"
	docker tag $REPO:$TRAVIS_COMMIT $REPO:$TRAVIS_BRANCH          # steinwaywhw/ats:branch
	docker push $REPO:$TRAVIS_BRANCH
fi




