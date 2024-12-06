# CICSdev stats

Download statistics for repos in the CICSDev org

## Summary

The [github-repo-stats GitHub Action](https://github.com/marketplace/actions/github-repo-stats) collects stats and generates [reports for each repository in the cicsdev organisation](https://github.com/cicsdev/repo-stats/tree/github-repo-stats/cicsdev) individually.

The `cicsdev-summary.sh` script can be used to create summary files for *clones*, *forks*, *stargazers*, and *views*. To run the script:

1. copy `cicsdev-summary.sh` to a suitable directory on your path, e.g. `~/bin`
2. clone the `repo-stats` repository
3. check out the `reports` branch
4. run `cicsdev-summary.sh` from the root of the `repo-stats` repository 
