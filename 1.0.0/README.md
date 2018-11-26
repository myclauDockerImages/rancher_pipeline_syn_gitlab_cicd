# rancher_pipeline_syn_gitlab_cicd
allow rancher pipeline to wait gitlab cicd finsh and do deployment


# Environment Variable (must be fill before using)
| Env Variable | Description |
| --- | --- |
| `GITLAB_TOKEN` | this is the account for git lab , to create this login to gitlab > setting > access token > create |
| `GITLAB_PIPELINE_URL` | this is the pipeline url show be something like `https://gitlab.example.com/api/v4/projects/:id/pipelines` to find it you can login gitlab > go to target project > Settings > CI/CD > Pipeline triggers press Expand > in example you will see the id of that project |
| `BRANCH` | this is the branch you are targeting |

# How to use
To be update
