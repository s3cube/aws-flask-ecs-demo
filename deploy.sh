#!/bin/sh

JQ="jq --raw-output --exit-status"

configure_aws_cli() {
  aws --version
  aws configure set default.region us-east-2
  aws configure set default.output json
  echo "AWS Configured!"
}

register_definition() {
  if revision=$(aws ecs register-task-definition --cli-input-json "$task_def" | $JQ '.taskDefinition.taskDefinitionArn'); then
    echo "Revision: $revision"
  else
    echo "Failed to register task definition"
    return 1
  fi
}

