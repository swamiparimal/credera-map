# Welcome to MAP! Here's some steps to get started:

## Initial Setup

1. Install AWS CLI (https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
   - Follow the steps appropriate for your OS
   - Verify that it's installed by running ``aws --version``

![AWS Version](/images/aws_version.png)   


3. Install Terraform for your OS (https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
   - If you are using MacOS, it is easier to use brew
   - If you are using Windows, remember to change your PATH once you've downloaded Terraform (https://learn.microsoft.com/en-us/azure/developer/terraform/get-started-windows-bash?tabs=bash Start from step 4 in this link)
6. Check to see if you already have an AWS account linked to your cli by running "aws configure" in your Command Line/Terminal
    - If you don't have anything setup, you should see "Access Key [None]". Exit out of this command for now
    - If you do, you should see "Access Key [*****random_characters]". <br/>
    
    ![AWS](/images/configure.png) <br/>

    In this scenario, you just have to specify a new user when running "aws configure" next (ex: "aws configure --map"). Then you will be prompted to enter in a new Access Key/Secret Key. <br/>

    ![New](/images/new_user.png) <br/>

    ***Note: if you have to make a new profile, you will eventually have to specify which profile is going to be used when you do Terraform commands.***

    - Reach out to Allen Clayton, Carter Pace, or Swami Parimal and they will be able to get you an Access Key/Secret Key. You should also be able 
   to see the resources in our AWS sandbox through the console
    - Use this Access Key/Secret Key in your ``aws configure`` command
    - Once you've entered this, run ``aws s3 ls`` and verify if you can view all the S3 buckets that are present in our sandbox environment

## Analyzing the Terraform files
There is a good chance that there are already a lot AWS resources already created and active by the Terraform files present in this repository. In order to maintain the state of our AWS resources, ***don't run any terraform commands just yet (especially not terraform apply!!!)***. 

## Configuring your Terraform file

Each set of Terraform files in a directory has a block of code similar to this in one of the files:

`` provider "aws" {
  region = "us-east-2"
  profile = "default"
} ``

Your profile will depend on whether or not you had to make a new profile when configuring your AWS CLI. If you did, be sure to change the profile entry to the correct entry. To find all of your AWS profiles, it's usually in the following file path for Mac users ``/Users/$(your username)/.aws/config``. You can also access it by entering ``~.aws/config`` into your Google Chrome browser. 

![Chrome](/images/chrome.png)

Now you are ready to start using Terraform. Be sure to name your new resources differently from any other resources created in our AWS Console. 

## Initial Commands to run
Once you are feeling comfortable with working in the state created, first run 
``terraform init`` in this directory. This initializes terraform

Next, make any changes to files or add files that you want to. Then, run the following command
`` terraform plan -out tfplan.out ``
This saves the planned output of the terraform script to and .out file. It should also tell you whether or not it's creating, destroying or changing any resources

Finally, run `` terraform apply tfplan.out `` to apply your changes. This will make/change/destroy the resources you've specified in your AWS account. Please make sure you have cleared these changes with Allen before running this command!


