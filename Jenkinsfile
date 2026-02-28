pipeline {
    agent none
    options {
        timestamps()
        disableConcurrentBuilds(abortPrevious: true)
    }
    stages {
        stage('machines') {
            matrix {
                agent {
                    label "linux && podman && kas"
                }
                axes {
                    axis {
                        name 'MACHINE'
                        values 'genericx86-64', 'raspberrypi3-64'
                    }
                }
                stages {
                    stage('build') {
                        steps {
                            checkout scm
                            sh "mkdir logs"
                            sh "kas-container build kas/${MACHINE}.yaml:kas/cve.yaml 2>&1 | tee logs/build_${MACHINE}.log"

                            recordIssues(
                                sourceCodeRetention: 'LAST_BUILD',
                                tools: [yoctoScanner(id: MACHINE, name: "$MACHINE CVEs", pattern: 'build/tmp/deploy/cve/cve-summary.json')]
                            )
                        }
                    }
                    stage('sdk') {
                        steps {
                            sh "kas-container build kas/${MACHINE}.yaml:kas/sdk.yaml 2>&1 | tee logs/sdk_${MACHINE}.log"
                        }
                    }
                }
                post { 
                    always {
                        archiveArtifacts artifacts: 'logs/*.log'
                    }
                    cleanup { 
                        cleanWs()
                    }
                }
            }
        }
    }
}
