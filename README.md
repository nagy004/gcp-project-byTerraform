#Read Me File ########################
This infrastructure built with terraform tool and it consist of :
1 VPC:
2 Subnets "management", "restricted"
NAT in "management" subnet
Private VM in "management" subnet to manage the cluster.
Private Kubernetes cluster in "restricted" subnet with 3 worker nodes.
2 Service Accounts
one for the private VM to manage the cluster
one used by the nodes in the cluster


After you applying the infrastructure code by using “terraform apply” command you will have to follow the stpes
1- you will have to connect to the private VM by using ssh 
2- install kubectl by using this command “ sudo apt-get install kubectl”
3- use this command to install plugins on your VM to prepare it to connect to your Cluster 
       “sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin “
4- now you will be able to connect the cluster
       (( you can use “ kubectl get nodes “  to show your nodes ))
5- Deploy the pods for cluster and redis using the attached yaml files
6-get the LoadBalancer  EXTERNAL-IP and put it in your browser it should show you the app page  gcp-project-byTerraform
