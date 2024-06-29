@Library('test-pipeline-library')_


pipeline {
  agent { label 'linux' }

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
            git clone https://github.com/dargamenteria/actividad1-D $WORKSPACE/gitCode
            '''
          )
          stash  (name: 'workspace')
        }
      }
    }



  }

}


