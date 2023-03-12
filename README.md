# GCP first infrastructure building project

The aim of this project is to build full infrastructure to deploy a python app in the cloud using Google cloud Platform (GCP) and its services like GKE, VM instance and VPC network and Terraform to build and destroy this infra easily instead of google cloud console

## This Repo contains the following folders

1. app-python - It contains python code and Dockerfile.
2. YamilFiles - It contains the essential files (.yaml).
3. Terraform files  to build our infra

## Dependencies

1. GCP account
    You would require to have an GCP account to be able to build cloud infrastructure.

2. VS code editor (with Terraform extension for auto complete)
    An editor would be helpful to visualize the image as well as code.

3. Terraform
    You would require to install Terraform to be able to build cloud infrastructure.

4. Git

## Required Infrastracture

![Screenshot from 2023-02-09 16-30-15](https://user-images.githubusercontent.com/57557314/217871474-502744c2-7391-4d5e-9f31-3764cc76432e.png)

## How to Use

1. Set up GCP

    **After creating your GCP account, create or modify the following resources to enable Terraform to provision your infrastructure:**

    - A GCP Project:Create one now in the GCP console and make note of the project id.
    - Google Compute Engine: Enable Google Compute Engine for your project in the GCP console. Make  sure to select the project you are created and click the "Enable" button.
    - A GCP service account key: Create a service account key to enable Terraform to access your GCP account.
    When creating the key, use the following settings:
      - Select the project you created in the previous step.
      - Click "Create Service Account".
      - Give it name(terraform-sa)  and click "Create".
      - For the Role, choose "Project -> Editor", then click "Continue".
      - Skip granting additional users access, and click "Done".
    - After you create your service account, download your service account key.
      - Select your service account from the list.
      - Select the "Keys" tab.
      - In the drop down menu, select "Create new key".
      - Leave the "Key Type" as JSON.
      - Click "Create" to create the key and save the key file to your system.
  
2. Clone current repository [GCP first infrastructure building project](https://github.com/nagy004/gcp-project-byTerraform)

    Note: Don't forget to copy credintial key to this directory and chenge it in code and also change project id with project id you created

    ``` bash
    #Run terraform init to initialize the project
    terraform init 
    #Run terraform plan to preview the changes that will be made
    terraform plan
    #Run terraform apply to create the resources
    terraform apply
    ```

3. From Local build and push images to GCR

   NOTE: Dockerfile will be found in app-python

    TO BUILD IMAGE

    ``` bash
    cp Dockerfile app-python
    cd app-python
    # tag should be hostname/projectID/imgName
    docker build . -t us.gcr.io/<project_id>/python-sample-app:v1.0 
    ```

    TO PUSH IMAGE TO GCR

    ```bash
    gcloud auth configure-docker
    gcloud docker -- push us.gcr.io/<project_id>/python-sample-app:v1.0 
    ```

4. SSH into the private VM and connect to cluster

    ```bash
     gcloud auth login
     sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin
     # sudo apt-get install kubectl
     gcloud components install kubectl
     #gcloud container clusters get-credentials k8s-cluster --zone us-central1-a --project shrouk-iti
     gcloud container clusters get-credentials [cluster-name] --zone [cluster-zone] --project[project-id]
    ```

5. Deploy our python application using K8s private cluster

    ```bash
    nano configmap.yaml #then copy config.yaml file content in it (from yamifiles directory)
    nano Deployment.yaml #then copy deployment.yaml file content in it (from yamifiles directory)
    nano Public_LoadBalancer.yaml #then copy service.yaml file content in it (from yamifiles directory)
    kubectl apply -f configmap.yaml
    kubectl apply -f Deployment.yaml
    kubectl apply -f Public_LoadBalancer.yaml
    ```

6. explore services to get the ip address of Load balancer

    ```bash
    kubectl get services
    ```

    ![result of get scv](result_Pics/LoadBalancerResult.png "External IP")

    and here we will take the External IP of the load balancer and the assigned port like that

    ```http:\\34.133.191.251:8000```

## And the output will be like that

![result of get scv](result_Pics/output.png "Output")
