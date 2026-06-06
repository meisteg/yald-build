def nexusUpload(files) {
    def uploadFiles = findFiles(glob: files)
    uploadFiles.each {
        echo "Found file: ${it.path}"

        withCredentials([usernamePassword(credentialsId: 'nexus', passwordVariable: 'NEXUS_PASSWORD', usernameVariable: 'NEXUS_USER')]) {
            sh """
                curl -u "\$NEXUS_USER:\$NEXUS_PASSWORD" --upload-file ${it.path} "${NEXUS_URL}/repository/${NEXUS_REPO_NAME}/${REMOTE_UPLOAD_PATH}/${it.path}"
            """
        }
    }
}

pipeline {
    agent none
    options {
        timestamps()
        disableConcurrentBuilds(abortPrevious: true)
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }
    environment {
        NEXUS_URL = "${JENKINS_URL.replace('8080/', '8081')}"
        NEXUS_REPO_NAME = 'raw-staging'
        REMOTE_UPLOAD_PATH = "meisteg/yald-build/${BRANCH_NAME}/${BUILD_NUMBER}"
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
                        values 'yald-x86-64'
                    }
                }
                stages {
                    stage('build') {
                        steps {
                            checkout scm
                            sh """
                                mkdir logs
                                set -o pipefail
                                kas-container build kas/${MACHINE}.yaml:kas/cve.yaml 2>&1 | tee logs/build_${MACHINE}.log
                            """

                            recordIssues(
                                sourceCodeRetention: 'LAST_BUILD',
                                tools: [yoctoScanner(id: MACHINE, name: "$MACHINE CVE", pattern: "build/tmp/deploy/images/${MACHINE}/yald-image-dev-${MACHINE}.rootfs.sbom-cve-check.yocto.json")],
                                failOnError: true
                            )
                        }
                    }
                    stage('sdk') {
                        steps {
                            sh """
                                set -o pipefail
                                kas-container build kas/${MACHINE}.yaml:kas/sdk.yaml 2>&1 | tee logs/sdk_${MACHINE}.log
                            """
                        }
                    }
                    stage('artifacts') {
                        steps {
                            dir("build/tmp/deploy") {
                                nexusUpload("images/${MACHINE}/*-${MACHINE}.rootfs.*, images/${MACHINE}/bzImage, sdk/*.sh")
                            }
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
