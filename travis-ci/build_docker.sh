#!/usr/bin/env sh

export REPO=steinwaywhw/ats
export COMMIT=${TRAVIS_COMMIT::8}

echo $1
echo $2

docker login -u $1 -p $2
docker build \
	-f Dockerfile \
	-t $REPO:$COMMIT \
	--build-arg ATSVER=${ATSVER} \
	.

if [ "$TRAVIS_BRANCH" == "master" ]; then 
	if [ -z "$TRAVIS_TAG" ]; then 
		docker tag $REPO:git                 # steinwaywhw/ats:git
	else 
		docker tag $REPO:$TRAVIS_TAG         # steinwaywhw/ats:1.0
		docker tag $REPO:latest              # steinwaywhw/ats:latest
	fi
else
	docker tag $REPO:$TRAVIS_BRANCH/git  # steinwaywhw/ats:branch/git
fi

docker push $REPO


