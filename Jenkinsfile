@Library('test-pipeline-library')_


pipeline {
  agent { label 'linux' }
  environment {
    AWS_ACCESS_KEY_ID     = credentials('aws_access_key_id')
    AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
    GITHUB_TOKEN          = credentials('github_token')
  }

  stages {
    stage('Pipeline Info') {
      steps {
        sh ('echo "        pipelineBanner "')
        pipelineBanner()
      }
    }

    stage('Get code') {
      agent { label 'linux' }
      steps {
        catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
          pipelineBanner()
          sh ('''
            [ -e "$WORKSPACE/gitCode" ] && rm -fr "$WORKSPACE/gitCode"
            git clone https://${GITHUB_TOKEN}@github.com/dargamenteria/actividad1-D $WORKSPACE/gitCode
            git checkout master
            '''
          )
          stash  (name: 'workspace')
        }
      }
    }

    
    stage ('Deploy') {
      agent { label 'linux' }
      steps {
        catchError(buildResult: 'FAILURE', stageResult: 'FAILURE') {
          pipelineBanner()
          unstash 'workspace'
          sh ('''
            cd "$WORKSPACE/gitCode"

            export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
            export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}

            sam build
            sam deploy 
            --stack-name todo-aws-list-production \
            --region eu-central-1 \
            --disable-rollback \
            --config-env production \
            --no-fail-on-empty-changes

            unset AWS_SECRET_ACCESS_KEY
            unset AWS_ACCESS_KEY_ID

            '''

          )
        }
      } 
    }

    stage ('Test Rest') {
      agent { label 'linux' }
      steps {
        catchError(buildResult: 'FAILURE', stageResult: 'FAILURE') {
          pipelineBanner()
          unstash 'workspace'
          lock ('test-resources'){
            sh ('''
              echo "Test phase"
              cd "$WORKSPACE/gitCode"

              export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
              export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}

              export BASE_URL=$(aws cloudformation describe-stacks --stack-name todo-aws-list-production    --query 'Stacks[0].Outputs[?OutputKey==`BaseUrlApi`].OutputValue'     --output text) 

              aws sts get-session-token > a.json
              # TODO do not show the passwords find another solution for masking

              export AWS_ACCESS_KEY_ID=$(cat a.json | jq $jq .Credentials.AccessKeyId)
              export AWS_SECRET_ACCESS_KEY=$(cat a.json | jq $jq .Credentials.SecretAccessKey)
              export AWS_SESSION_TOKEN=$(cat a.json | jq $jq .Credentials.SessionToken)

              pytest --junitxml=result-rest.xml -m readonly $(pwd)/test/integration/todoApiTest.py
              '''
            )
          }
          stash  (name: 'workspace')
        }
      }
    }

    stage ('Test Results') {
      agent { label 'linux' }
      steps {
        pipelineBanner()
        catchError(buildResult: 'SUCCESS', stageResult: 'SUCCESS') {
          unstash 'workspace'
          junit allowEmptyResults: true, testResults: 'gitCode/result-*.xml'
        }
      }
    }

   
  }//end stages

  post {
    always {
      cleanWs()
    }
  }
}


