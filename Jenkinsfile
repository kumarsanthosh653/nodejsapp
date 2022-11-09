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
    imagePullPolicy: Always
    command:
    - cat
    tty: true
    volumeMounts:
      - name: docker-config
        mountPath: /kaniko/.docker
    volumes:
    - name: docker-config
      configMap:
        name: docker-config
''') {
  node(POD_LABEL) {
    stage('Get a Nodejs project') {
      git url: 'https://github.com/saiteja3747/nodejsapp.git', branch: 'main'
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
            /kaniko/executor --context `pwd` --destination 031141521775.dkr.ecr.ap-south-1.amazonaws.com/nodejsapp:latest --destination  031141521775.dkr.ecr.ap-south-1.amazonaws.com/nodejsapp:v$BUILD_NUMBER
          '''
        }
      }
    }

  }
}
