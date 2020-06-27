###(Optinal)  Create a 3 node environment with GCP###

1. Rename the file terraform.tfvars.sample to terraform.tfvars adding your own credentials and a project 

project = "<Project>"
credentials_file = "<credentials>.json"

Use terraform to provision the environment
`terraform init`
`terraform apply`

Use gcloud to login into your servers like the following command

`gcloud beta compute ssh "control" --ssh-flag="-A"`


#Install a cluster with kubeadm#

1. Install Docker

https://docs.docker.com/engine/install/ubuntu/


On Unbuntu:
`sudo apt-get remove docker docker-engine docker.io containerd runc`

Allow apt to user https
```
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
```

Add Dockers keys
`curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -`

Add Repository

```
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
```

sudo apt-get install -y docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker your-user


2. Install kubelet, kubectl and kubeadm

https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

```
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
```

systemctl daemon-reload
systemctl restart kubelet


3. To make your kubectl work in the control node
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


