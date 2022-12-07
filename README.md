Welcome to MAP! Here's some steps to get started:

1. Install AWS CLI (https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
   - Follow the steps appropriate for your OS
   - Verify that it's installed by running "aws -version"
3. Install Terraform for your OS (https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
   - If you are using MacOS, it is easier to use brew
   - If you are using Windows, remember to change your PATH once you've downloaded Terraform (https://learn.microsoft.com/en-us/azure/developer/terraform/get-started-windows-bash?tabs=bash start from step 4 in this link)
6. Check to see if you already have an AWS account linked to your cli by running "aws configure" in your Command Line/Terminal
    - If you don't have anything setup, you should see "Access Key [None]"
    - If you do, you should see "Access Key [*****random_characters]". In this scenario, you just have to specify a new user when running "aws configure" next (ex: "aws configure --map")
    - Reach out to Allen Clayton, Carter Pace, or Swami Parimal and they will be able to get you an Access Key/Secret Key. You should also be able 
   to see the resources in our AWS sandbox through the console
    - Use this Access Key/Secret Key in your "aws configure" command
    - Once you've entered this, run "aws s3 ls" and verify if you can view all the S3 buckets that are present in our sandbox environment

