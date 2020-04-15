# Welcome to Dumb app!

# Testing locally

After you've made changes to the code you will need to rebuild the docker image and launch the container. To do so, execute the following commands in the same directory as the Dockerfile:

```bash
# Build the image
docker build -t dumb_app .

# Launch a container using the dumb_app image you just built
docker run -p 3000:8080 dumb_app
```
The app should be running on localhost:3000

## Deploying your app to an existing AWS instance using a shell script
### Prerequisites
Launch an EC2 instance on AWS and get the public address of that instance.

Make sure ports 22 and 3000 are accessible by your machine

Create a config.sh file in the aws_shell directory, paste the following lines in that file
```bash
#!/usr/bin/env bash

private_key_path="/path/to/your/private/key" # UPDATE THIS VALUE
instance_public_address="ec2_instance_public_address" # UPDATE THIS VALUE
```

### Deploying the app to the EC2 instance
Go into the aws_shell directory and run the following command
```bash
sh deploy_app.sh branch_you_want_to_deploy
```
To check that the app is running go to ec2_instance_public_address:3000 in your browser.
## Deploying your app to GCP
### Prerequisites
Have terraform installed on your machine

Download credentials from the [the service account key page in the Cloud Console ](https://console.cloud.google.com/apis/credentials/serviceaccountkey)
Once the json file has been downloaded, set the following environment variable:
```bash
export GOOGLE_CLOUD_KEYFILE_JSON=/path/to/json/file
```

Now go into the terraform folder and create a new file called variables.tf and paste the following lines:
```bash
variable  "gcp_user"  {
	default = "you_gcp_user" # UPDATE THIS VALUE
}

variable  "gcp_project_id"  {
	default = "your_gcp_project_id" # UPDATE THIS VALUE
}

variable "branch" {
    default = "master"
}
```
### Deploying the app
Go into the terraform folder and run the following commands:
```bash
terraform init
terraform apply -var "branch=branch_you_want_to_deploy"# Write yes when prompted to do so
```

Your app should now be up and running, to get the external IP you can go to the compute page of your GCP account.

To check that the app is running go to external_ip:3000 in your browser.

### Stopping the app
Go to the terraform folder and run:
```bash
terraform destroy # Write yes when prompted to do so
```

Everything has been deleted and your app is no longer running.