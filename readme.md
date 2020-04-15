# Welcome to Dumb app!

# Testing locally

After you've made changes to the code you will need to rebuild the docker image and launch the container. To do so, execute the following commands in the same directory as the Dockerfile:

```bash
#Build the image
docker build -t dumb_app .

# Launch a container using the dumb_app image you just built
docker run -p 3000:8080 dumb_app
```

## Deploying your app to GCP
### Prerequisites
Have terraform installed on your machine

Download credentias from the [the service account key page in the Cloud Console ](https://console.cloud.google.com/apis/credentials/serviceaccountkey)
Once the json file has been download set the following environment variable:
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
```
### Deploying the app
Go into the terraform folder and run the following commands:
```bash
terraform init
terraform apply -var "branch=branch_you_want_to_deploy"# Write yes when prompted to do so
```

Your app should now be up and running, to get the external IP you can go to the compute page of your GCP account.

To check that the app is running go to <IP>:3000 in your browser.

### Stopping the app
Go to the terraform folder and run:
```bash
terraform destroy # Write yes when prompted to do so
```

Everything has been deleted and your app is no longer running.