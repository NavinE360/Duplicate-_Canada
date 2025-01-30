Project:
End to End DevOps Deployment for Expense Tracker Application.

Project Scope:    To mplement DevOps Cycle for an  Application Deployment (Expense tracker Application).
                  Automate application delivery with industry best practises
                  Focus on operational efficiency , scalability, and reliability!

project Goals:    Reduce the Deployment by 40%.
                  Ensure 99.9% uptime.
                  Support up to 10,000 concurrent users.


Inputs ,prerequisites and Initial Setup:
                 A Cloud Account (AWS ,Azure, or Google)
                 Docker Hub Account – To host containerized images of the microservices.
                 Git Repository:	The cloned repository of the Expense Tracker application, which includes Frontend built in Next.js Backend built in Node.js
                 Estimated Costs: Utilize cost –saving practises like spot instances.

Web Application overview: Application:  Expense Tracker  
                                        Backend: Node.js
                                        Frontend: Next.js 
                                        Database: MongoDB
                                        Cache: Redis
                                        Architecture: Stateful microservices, horizontal & Vertical scaling.

Execution: 
           Dokcer:
           1.Created the Docker files for Frontend and backend services in the local system.
           2.Build the Docker images and containers for all the 4 microservices (front,backend,redis,MongoDB) , ensured all the containeers are working in the local system and also checked at 
             their respective ports in web browwser.
           3.created a docker compose file for all the mocroservices and ensured all the microservices are working and and also checked at their respective ports in web browwser.
           4.Pushed the Docker images to the docker hub.
Commands:     docker build -t navin360/frontend2201 .
              docker build -t navin360/backend2201 .

              docker run -d navin360/frontend2201
              docker run -d navin360/backend2201

              docker psuh navin360/frontend2201
              docker psuh navin360/backend2201

          Kubernetes:
          1.create the kubernetes Deployment manifest files for frontend deployment and service,Backend deployment and service,database deployment (mangoDB)and service,Redis deployment and 
            service,also create persistent volume and claim files for mangoDB and Redis.
          2.create a kluster and deploy all the files and chekc the deployments (except frontend and its service), services and pods are running.
          3.Copy the loadbalancer url of backend after service deployment and paste it in the frontend deployment and deploy front end and its service.
          3.Access the frontned and backend with load balncer url in the webbrowser at their respective ports.


Commands: eksctl create cluster --name <my-cluster> --region <region-code>
          kubectl get nodes -o wide
          kubectl get pods -A -o wide
          aws eks update-kubeconfig --region <region-code> --name <my-cluster>
          kubectl apply -f backend-deploy.yaml
          kubectl apply -f backend-service.yml
          kubectl apply -f database-deploy.yaml
          kubectl apply -f database-service.yml
          kubectl apply -f database-pv.yml
          kubectl apply -f database-pvc.yml
          kubectl apply -f redis-deployment.yml
          kubectl apply -f redis-service.yml
          kubectl apply -f redis-pv.yml
          kubectl apply -f redis-pvc.yml
          kubectl apply -f frontend-deploy.yaml
          kubectl apply -f frontend-service.yml
          kubectl get deployments 
          kubectl get svc
          kubectl get pods

         Till now all the deploymentas and services are done at local system.

         Infrasture for EKS kluster is created with terrform and then all the deployments which are done earlier will be re-deployed on the kluster.

         Terraform:
                    1.Created terrafom files for VPC,EKs,S3 bucket,dynamoDB etc.
                    2.kluster is setup in the AWS and also configured.
                    3.check the kluster nodes and check the access .
                    4.deploy all the deployments on the created cluster and ensure all the deployments are running.

commands: terraform init
          terraform validate
          terraform plan
          terraform apply
          
          
          CICD:      
                  1.created a workflow file for both build (on local ubuntu) and deploy (with self hosted runner) assign the kluster which is created from terraform files.
                  2.create an EC2 instance to setp an self hosted runner,install docker,aws cli and configure, kubectl.allow the respective ports in security group.
                  3. deploy on the EC instance with self hosted runner and ensure deploy is succeeded.
                  4 .ensure all the deployments , services, and pods are running succesfully (copy the backedn url to the frontend like setps before)

         Monitoring:

                  1.Install prometheues and grafana in the EC2 self hosted runner machine using helm package.
                  2.Acces the prometheus and grafan at their respetive ports.
                  3.After succesfull login to the grafana , check the dashboards of the kubernets kluster data like cpu usage, pods ,nodes etc.

                  

                    
