# Container image that runs your code
FROM ferrarimarco/github-changelog-generator:1.15.0

COPY changelog.sh /changelog.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/changelog.sh"]
