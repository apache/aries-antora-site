pipeline {
    agent {
        label 'git-websites'
    }

    stages {
        stage('trigger-site-build') {
            when {
                branch 'master'
//                 changeset '**/*.adoc'
            }

            steps {
                build job: 'Aries/aries-website', wait: false
            }
        }
    }
}