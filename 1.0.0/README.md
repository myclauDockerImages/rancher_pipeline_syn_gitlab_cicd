# rancher_pipeline_syn_gitlab_cicd
allow rancher pipeline to wait gitlab cicd finsh and do deployment, Gitlab need at least version 10.2


# Environment Variable (must be fill before using)
| Env Variable | Description |
| --- | --- |
| `GITLAB_TOKEN` | this is the account for git lab , to create this login to gitlab > setting > access token > create |
| `GITLAB_PIPELINE_URL` | this is the pipeline url show be something like `https://gitlab.example.com/api/v4/projects/:id/pipelines` to find project id Enter the project -> On the Left Hand menu click Settings -> General -> Expand General Settings -> It has a label Project ID and is next to the project name |
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

