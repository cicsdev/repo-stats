# CICSdev stats

Download statistics for repos in the CICSDev org

## Summary

The [github-repo-stats GitHub Action](https://github.com/marketplace/actions/github-repo-stats) collects stats and generates [reports for each repository in the cicsdev organisation](https://github.com/cicsdev/repo-stats/tree/github-repo-stats/cicsdev) individually.

The `cicsdev-summary.sh` script can be used to create summary files for *clones*, *forks*, *stargazers*, and *views*. To run the script:

1. copy `cicsdev-summary.sh` to a suitable directory on your path, e.g. `~/bin`
2. clone the `repo-stats` repository
3. check out the `github-repo-stats` branch
4. run `cicsdev-summary.sh` from the root of the `repo-stats` repository 

## TODO

Get the list of repos automatically instead of hard coding it in the workflow

For now, the following command will fetch a list of public repos for pasting in

```
curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "https://api.github.com/orgs/cicsdev/repos?per_page=100&type=public" | \
yq '[.[].full_name | select(. != "cicsdev/cicsdev.github.io")]'
```
