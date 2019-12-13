#!/bin/sh

github_changelog_generator -u $1 -p $2 -o --release-branch $3 -o CHANGELOG.md

changelog=`cat CHANGELOG.md`
echo ::set-output name=changelog::$changelog
