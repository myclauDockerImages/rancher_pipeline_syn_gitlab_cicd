# rancher_pipeline_syn_gitlab_cicd
allow rancher pipeline to wait gitlab cicd finsh and do deployment


# Environment Variable (must be fill before using)
| Env Variable | Description |
| --- | --- |
| `GITLAB_TOKEN` | this is the account for git lab , to create this login to gitlab > setting > access token > create |
| `GITLAB_PIPELINE_URL` | this is the pipeline url show be something like `https://gitlab.example.com/api/v4/projects/:id/pipelines` to find it you can login gitlab > go to target project > Settings > CI/CD > Pipeline triggers press Expand > in example you will see the id of that project |
| `BRANCH` | this is the branch you are targeting |

# How to use
setup the .rancger-pipeline.yml like this
``` yml
stages:
- name: Wait docker image build ready in gitlab
  steps:
  - runScriptConfig:
      image: myclau/rancher-pipeline-syn-gitlab-cicd
      shellScript: docker-entrypoint.sh
    env:
      BRANCH: ${CICD_GIT_BRANCH}
      GITLAB_PIPELINE_URL: <url>
      GITLAB_TOKEN: <gitlab-access-token>
- name: Deploy
  steps:
  - applyYamlConfig:
      path: ./deployment.yaml
timeout: 60

```
if you want to put token into secret:
```yml
stages:
- name: wait docker image ready
  steps:
  - runScriptConfig:
      image: myclau/rancher-pipeline-syn-gitlab-cicd
      shellScript: docker-entrypoint.sh
    env:
      BRANCH: ${CICD_GIT_BRANCH}
      GITLAB_PIPELINE_URL: <url>
    envFrom:
    - sourceName: <gitlab-access-token-secret-name>
      sourceKey: token
      targetKey: GITLAB_TOKEN
- name: Deploy
  steps:
  - applyYamlConfig:
      path: ./deployment.yaml
timeout: 60

```

