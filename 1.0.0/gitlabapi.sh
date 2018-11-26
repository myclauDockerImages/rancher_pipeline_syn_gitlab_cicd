#!/usr/bin/env bash
status="pending"
token=${GITLAB_TOKEN-"9koXpg98eAheJpvBs5tK"}
pipelineurl=${GITLAB_PIPELINE_URL-"https://gitlab.example.com/api/v4/projects/1/pipelines"}
branch=${BRANCH-"new-pipeline"}

while [ "$status" == "pending" ] || [ "$status" == "running" ];
do
status=$(curl --header "PRIVATE-TOKEN: $token" "$pipelineurl" | jq -r --arg ref "$branch" 'map(select(.ref==$ref))| .[0].status')
if [ "$status" == "canceled" ] || [ "$status" == "failed" ] || [ "$status" == "$null" ]; then
echo "$status on Gitlab"
exit 1
else
echo "$status on Gitlab"
fi

sleep 10
done
