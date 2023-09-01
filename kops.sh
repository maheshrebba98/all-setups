#vim .bashrc
#export PATH=$PATH:/usr/local/bin/
#source .bashrc


#! /bin/bash
aws configure
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
wget https://github.com/kubernetes/kops/releases/download/v1.25.0/kops-linux-amd64
chmod +x kops-linux-amd64 kubectl
mv kubectl /usr/local/bin/kubectl
mv kops-linux-amd64 /usr/local/bin/kops

aws s3api create-bucket --bucket rahamssshaik09.k8s.local --region us-east-1
aws s3api put-bucket-versioning --bucket rahamssshaik09.k8s.local --region us-east-1 --versioning-configuration Status=Enabled
export KOPS_STATE_STORE=s3://rahamssshaik09.k8s.local
kops create cluster --name rahams.k8s.local --zones us-east-1a --master-count=1 --master-size t2.medium --node-count=2 --node-size t2.micro
kops update cluster --name rahams.k8s.local --yes --admin
### Here, executing script we need execute again commands
   # cat file name.yml --> export KOPS_STATE_STORE=s3://rahamssshaik09.k8s.local
   # kops validate cluster --wait 10m

# List cluster : kops get cluster
# Edit the Cluster name : kops edit rahams.k8s.local 
# Edit the node instance-group for no.of worker nodes : kops edit ig --name=rahams.k8s.local nodes-us-east-1a
# Edit the Master instance-group for no.of Master nodes : kops edit ig --name=rahams.k8s.local master-us-east-1a
     # after modifed the command in below commands need to update the cluster : kops update cluster --name rahams.k8s.local --yes --admin
     # Restart the cluster will get other command and run it : kops rolling-update cluster --yes
