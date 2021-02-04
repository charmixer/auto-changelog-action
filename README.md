# Available inputs

```yaml
user:
  description: 'Username of the owner of target GitHub repo (default: extracted from $GITHUB_REPOSITORY)'
  required: false
project:
  description: 'Name of project on GitHub (default: extracted from $GITHUB_REPOSITORY)'
  required: false
release_branch:
  description: 'Limit pull requests to the release branch, such as master or release (required, default: master)'
  required: false
  default: 'master'
output:
  description: 'Output file. To print to STDOUT instead, use blank as path. (required, default: CHANGELOG.md)'
  required: false
  default: 'CHANGELOG.md'
base:
  description: 'Optional base file to append generated changes to (default: HISTORY.md)'
  required: false
token:
  description: 'To make more than 50 requests per hour your GitHub token is required. You can generate it at: https://github.com/settings/tokens/new<Paste>'
  required: false
since_tag:
  description: 'Changelog will start after specified tag.'
  required: false
due_tag:
  description: 'Changelog will end before specified tag.'
  required: false
exclude_tags:
  description: 'Changelog will exclude specified tags (comma seperated)'
  required: false
exclude_labels:
  description: 'Issues with the specified labels will be excluded from changelog. Default is "duplicate,question,invalid,wontfix".'
  required: false
date_format:
  description: 'Date format. Default is %Y-%m-%d'
  required: false
future_release:
  description: 'Put the unreleased changes in the specified release number.'
  required: false
issue_line_labels:
  description: 'The specified labels will be shown in brackets next to each matching issue. Use "ALL" to show all labels. Default is [].'
  required: false
github_site:
  description: 'The Enterprise GitHub site where your project is hosted if using GitHub Enterprise.'
  required: false
github_api:
  description: 'The enterprise endpoint to use for your GitHub API if using GitHub Enterprise.'
  required: false
exclude_tags_regex:
  description: 'Apply a regular expression on tag names so that they can be excluded, for example: --exclude-tags-regex ".*+d{1,}".'
  required: false
```


# Example

```yaml
name: Changelog

on:
  pull_request:
    types: [closed]

  release:
    types: [published]

  issues:
    types: [closed, edited]

jobs:
  generate_changelog:
    runs-on: ubuntu-latest
    name: Generate changelog for master branch
    steps:
      - uses: actions/checkout@v1

      - name: Generate changelog
        uses: charmixer/auto-changelog-action@v1
        with:
          token: ${{ secrets.YOUR_GITHUB_TOKEN or GITHUB_TOKEN }}

      - name: Commit files
        env:
          CI_USER: ${{ secrets.YOUR_GITHUB_USER }}
          CI_EMAIL: ${{ secrets.YOUR_GITHUB_EMAIL }}
        run: |
          git config --local user.email "$CI_EMAIL"
          git config --local user.name "$CI_USER"
          git add CHANGELOG.md && git commit -m 'Updated CHANGELOG.md' && echo "push=true" >> $GITHUB_ENV || echo "No changes to CHANGELOG.md"

      - name: Push changes
        if: env.push == 'true'
        env:
          CI_USER: ${{ secrets.YOUR_GITHUB_USER }}
          CI_TOKEN: ${{ secrets.YOUR_GITHUB_TOKEN or GITHUB_TOKEN }}
        run: |
          git push "https://$CI_USER:$CI_TOKEN@github.com/$GITHUB_REPOSITORY.git" HEAD:master

```
