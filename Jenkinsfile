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
        - 999999
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
    stage('Get a nodejs project') {
      git url: 'https://github.com/saiteja3747/nodejsapp.git', branch: 'master'    
      container('nodejs') {
        stage('Build a nodejs project') {
          sh '''
            echo pwd
          '''
        }
      }
    }
    
    stage('Build nodejs Image') {
      container('kaniko') {
        stage('Build a project') {
          sh '''
            /kaniko/executor --context `pwd` --destination 031141521775.dkr.ecr.ap-south-1.amazonaws.com/nodejsapp:$BUILD_NUMBER && \
             /kaniko/executor --context `pwd` --destination 031141521775.dkr.ecr.ap-south-1.amazonaws.com/nodejsapp:latest
          '''
        }
      }
    }
    stage ( 'k8s deployment') {
      container ('kubectl') {
	stage (' Deploy nodejs app') {
	  sh 'kubectl apply -f flux.yml' 
	  sh 'kubectl aply -f ingress.yml'
	}
      }
    }
  }
		  
  

