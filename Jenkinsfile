pipeline {
    agent {
        label 'git-websites'
    }

    stages {
        stage('trigger-site-build') {
            when {
                branch 'master'
                changeset '**/*'
            }

            steps {
                build job: 'Aries/aries-website', wait: false
            }
        }
    }
}