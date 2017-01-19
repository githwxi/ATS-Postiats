#!/usr/bin/env sh

export REPO=steinwaywhw/ats

echo $1
echo $2

docker login -u $1 -p $2
docker build \
	-f Dockerfile \
	-t $REPO:$TRAVIS_COMMIT \
	--build-arg ATSVER=${ATSVER} \
	.

if [ "$TRAVIS_BRANCH" == "master" ]; then 
	if [ -z "$TRAVIS_TAG" ]; then 
		docker tag $REPO:$TRAVIS_COMMIT $REPO:git                 # steinwaywhw/ats:git
	else 
		docker tag $REPO:$TRAVIS_COMMIT $REPO:$TRAVIS_TAG         # steinwaywhw/ats:1.0
		docker tag $REPO:$TRAVIS_COMMIT $REPO:latest              # steinwaywhw/ats:latest
	fi
else
	docker tag $REPO:$TRAVIS_BRANCH/git  # steinwaywhw/ats:branch/git
fi

docker push $REPO


