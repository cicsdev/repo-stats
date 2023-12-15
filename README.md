# repo-stats

Download statistics for repos in the CICSDev org

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
