#!/bin/bash
until [[ "$rez" = "0%" ]]
do
rez=$(ping -c 1 8.8.8.8 | grep % | cut -d ' ' -f6)
done

kubectl create ns jenkins

cat> deployment.yaml << EOF
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
 name: jenkins-home-claim
spec:
 accessModes:
 - ReadWriteOnce
 resources:
   requests:
     storage: 10Gi

---

apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: jenkins-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: jenkins
  template:
    metadata:
      labels:
        app: jenkins
    spec:
      initContainers:
      - name: take-data-dir-ownership
        image: busybox
        command:
        - chown
        - -R  
        - 1000:1000
        - /var/jenkins_home
        volumeMounts:
        - name: jenkins-home
          mountPath: /var/jenkins_home
      containers:
      - name: jenkins
        image: jenkinsci/blueocean
        env:
        - name: JAVA_OPTS
          value: "-Djenkins.install.runSetupWizard=false"
        ports:
        - containerPort: 8080
          containerPort: 50000
        volumeMounts:
        - name: jenkins-home
          mountPath: /var/jenkins_home
      volumes:
      - name: jenkins-home
        persistentVolumeClaim:
          claimName: jenkins-home-claim

---

apiVersion: v1
kind: Service
metadata:
  name: jenkins
spec:
  type: LoadBalancer
  ports:
    - port: 80
      targetPort: 8080
      protocol: TCP
  selector:
    app: jenkins

---

apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: jenkins
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: k8s-jenkins.ayoursh.playpit.net
    http:
      paths:
      - backend:
          serviceName: jenkins
          servicePort: 80
EOF

kubectl apply -f deployment.yaml --namespace=jenkins