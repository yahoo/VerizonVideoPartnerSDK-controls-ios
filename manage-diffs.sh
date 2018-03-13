#!/bin/bash

curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
aws configure set default.region eu-west-2
aws configure set aws_access_key_id $AWS_ACCESS_KEY
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY

if [ $TRAVIS_TEST_RESULT != 0 ]; then
    if [ -d ./SnapshotTests/Tests/FailureDifferences ]; then
        aws s3 rm --recursive s3://$S3_BUCKET/Failures/$TRAVIS_BRANCH/;
        aws s3 cp ./SnapshotTests/Tests/FailureDifferences s3://$S3_BUCKET/Failures/$TRAVIS_BRANCH/ --recursive --include "*.jpg" --exclude "*.DS_Store" --acl public-read;
        aws s3api list-objects --bucket aol-public --query 'Contents[].Key' --prefix Failures/$TRAVIS_BRANCH | tee keys.json; bundle exec danger --verbose;
    fi
else
    aws s3 rm --recursive s3://$S3_BUCKET/Failures/$TRAVIS_BRANCH/;
    bundle exec danger --verbose;
fi
