[![Lint](https://github.com/nikolajovancevic/automating-stuff/actions/workflows/lint.yml/badge.svg?branch=develop&event=push)](https://github.com/nikolajovancevic/automating-stuff/actions/workflows/lint.yml)
[![Tests](https://github.com/nikolajovancevic/automating-stuff/actions/workflows/tests.yml/badge.svg?branch=develop&event=push)](https://github.com/nikolajovancevic/automating-stuff/actions/workflows/tests.yml)
[![Deploy to test env](https://github.com/nikolajovancevic/automating-stuff/actions/workflows/deploy.yml/badge.svg?branch=develop&event=deployment_status)](https://github.com/nikolajovancevic/automating-stuff/actions/workflows/deploy.yml)
[![semantic-release: conventionalcommits](https://img.shields.io/badge/semantic--release-conventionalcommits-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release)

# Automating Stuff

## Table of Contents

- [Description](#description)
- [Test Development Gudelines](#test-development-guidelines)

## Description

Practicing CI/CD on GH using GitActions.

The flow:
- create PR from branch `feat-1` to `develop`
- all checks pass - `pr.yml`, `lint.yml`, `tests.yml`. PR must be approved as well.
- squash and merge PR
- `release.yml` is being triggered for each push to `develop` branch, based on PR title it will bump new version or not
- if new version is bumped the tag is being pushed to GH and `CHANGELOG.md` is being updated
- `deploy.yml` runs if `release.yml` has finished successfully and deploys new version to my [github page](https://nikolajovancevic.github.io/automating-stuff/) hosted on github.  

Following guidelines of [semver](https://semver.org/) convention. 

For release configuration check `.releaserc.json` file. 

Something like this: 

![Release flow](https://github.com/nikolajovancevic/automating-stuff/blob/develop/the-flow.png)


## Test Development Guidelines

### **Git**

The source of truth is the `develop` branch, meaning all work should be done in
relation to it.

Creating new branch example:

```
git checkout -b feat-short_description
```

### **Commiting**
Using [Commitizen](https://github.com/commitizen/cz-cli) for more consistent commit messages, as well as compatibility with semantic-release flow in general.

I've added script in `package.json` which will stage changes and initiate the commit:
```
npm run commit
```
Tech stack 
[Semantic release](https://semantic-release.gitbook.io/semantic-release).

### **Pull request**

Pull request title should follow [conventional](https://www.conventionalcommits.org/en/v1.0.0/) commits in order for `pr.yml` to pass and for `semantic-release` to work.

Acceptable PR title examples:
- `feat(breaking): Short pull request description` - bumps MAJOR
- `feat: Short pull request description` - bumps MINOR
- `fix: Short pull request description` - bumps PATCH
- `feat(no-release): Short pull request description` - no release