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
                        values 'genericx86-64', 'raspberrypi3-64'
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

                            script {
                                // Raspberry PI doesn't work with the debug sources, so use the spdx instead
                                if (MACHINE == 'raspberrypi3-64') {
                                    sh "python3 layers/openembedded-core/scripts/contrib/improve_kernel_cve_report.py \
                                            --spdx build/tmp/deploy/spdx/3.0.1/raspberrypi3_64/recipes/recipe-linux-raspberrypi.spdx.json \
                                            --datadir vulns \
                                            --old-cve-report build/tmp/log/cve/cve-summary.json \
                                            --new-cve-report build/tmp/log/cve/cve-summary-enhance_${MACHINE}.json"
                                } else {
                                    sh "python3 layers/openembedded-core/scripts/contrib/improve_kernel_cve_report.py \
                                            --debug-sources build/tmp/pkgdata/${MACHINE}/debugsources/linux-yocto-debugsources.json.zstd \
                                            --datadir vulns \
                                            --old-cve-report build/tmp/log/cve/cve-summary.json \
                                            --new-cve-report build/tmp/log/cve/cve-summary-enhance_${MACHINE}.json"
                                }
                            }

                            // Want to use the enhanced report, but new CVEs that do not have a score trip up the plugin.
                            recordIssues(
                                sourceCodeRetention: 'LAST_BUILD',
                                tools: [yoctoScanner(id: MACHINE, name: "$MACHINE CVE", pattern: 'build/tmp/log/cve/cve-summary.json')],
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
                                nexusUpload("images/${MACHINE}/yald-image-*-${MACHINE}.rootfs.wic.*, sdk/*.sh")
                            }
                        }
                    }
                }
                post { 
                    always {
                        archiveArtifacts artifacts: 'logs/*.log, build/tmp/log/cve/cve-summary-enhance_*.json'
                    }
                    cleanup { 
                        cleanWs()
                    }
                }
            }
        }
    }
}
