#!/bin/sh

# required
USER=$1
PROJECT=$2
RELEASE_BRANCH=$3
OUTPUT=$4

# optional
TOKEN=$5
SINCE_TAG=$6
DUE_TAG=$7
EXCLUDE_TAGS=$8
DATE_FORMAT=$9

if [ -z "$USER"]; then
  echo "Missing user input [\$1]"
  exit 1
fi

if [ -z "$PROJECT"]; then
  echo "Missing project input [\$2]"
  exit 1
fi

if [ -z "$RELEASE_BRANCH"]; then
  echo "Missing release branch input [\$3]"
  exit 1
fi

ARG_USER=""
if [ ! -z "$USER" ]; then
  ARG_USER="--user=\"$USER\""
fi

ARG_PROJECT=""
if [ ! -z "$PROJECT" ]; then
  ARG_PROJECT="--project=\"$PROJECT\""
fi

ARG_RELEASE_BRANCH=""
if [ ! -z "$RELEASE_BRANCH" ]; then
  ARG_RELEASE_BRANCH="--release-branch=\"$RELEASE_BRANCH\""
fi

ARG_OUTPUT=""
if [ ! -z "$OUTPUT" ]; then
  ARG_OUTPUT="--output=\"$OUTPUT\""
fi

ARG_TOKEN=""
if [ ! -z "$TOKEN" ]; then
  ARG_TOKEN="--token=\"$TOKEN\""
fi

ARG_SINCE_TAG=""
if [ ! -z "$SINCE_TAG" ]; then
  ARG_SINCE_TAG="--since-tag=\"$SINCE_TAG\""
fi

ARG_DUE_TAG=""
if [ ! -z "$DUE_TAG" ]; then
  ARG_DUE_TAG="--due-tag=\"$DUE_TAG\""
fi

ARG_EXCLUDE_TAGS=""
if [ ! -z "$EXCLUDE_TAGS" ]; then
  ARG_EXCLUDE_TAGS="--exclude-tags=\"$EXCLUDE_TAGS\""
fi

ARG_DATE_FORMAT=""
if [ ! -z "$EXCLUDE_TAGS" ]; then
  ARG_DATE_FORMAT="--date-format=\"$DATE_FORMAT\""
fi

github_changelog_generator $ARG_USER $ARG_PROJECT $ARG_RELEASE_BRANCH $ARG_OUTPUT $ARG_TOKEN $ARG_SINE_TAG $ARG_DUE_TAG $ARG_EXCLUDE_TAGS $ARG_DATE_FORMAT
