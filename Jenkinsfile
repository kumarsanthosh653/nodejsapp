podTemplate(yaml: '''
    apiVersion: v1
    kind: Pod
    spec:
      containers:
      - name: nodejs
        image: node:6-alpine
        command:
        - sleep
        args:
        - 99d
        - name: kubectl
        image: bitnami/kubectl
        command:
        - sleep
        args:
        - 9999999
      - name: kaniko
        image: gcr.io/kaniko-project/executor:debug
        command:
        - sleep
        args:
        - 9999999
        volumeMounts:
        - name: kaniko-secret
          mountPath: /kaniko/.docker
      restartPolicy: Never
      volumes:
      - name: kaniko-secret
        secret:
            secretName: dockercred
            items:
            - key: .dockerconfigjson
              path: config.json
''') {
  node(POD_LABEL) {
    stage('Get a Nodejs project') {
      git url: '', branch: 'main'
      container('node') {
        stage('Build a Nodejs project') {
          sh '''
          echo pwd
          '''
        }
      }
    }

    stage('Build Nodejs Image') {
      container('kaniko') {
        stage('Build a Go project') {
          sh '''
            /kaniko/executor --context `pwd` --destination 031141521775.dkr.ecr.ap-south-1.amazonaws.com/nodejsapp
          '''
        }
      }
    }

  }
}
