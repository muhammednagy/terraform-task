# IaC Cloudfront + s3 with different account with alternate domain
Terraform project that creates an S3 bucket and a cloudfront distribution to serve content from that bucket (from different accounts) with alternate domain support

Feel free to check the end result [here](https://cloudfront.muhnagy.com)
## Setup

1. Clone this repo.

2. Install `awscli`:
   ```sh
    brew install awscli  # OS X
    apt install awscli   # Ubuntu
    ```

3. Create AWS connection profiles:
   ```
   s3
   cloudfront
   ```

   Example for `cloudfront`:
   ```
   aws configure --profile cloudfront

     AWS Access Key ID [None]: YOURACCESSKEY
     AWS Secret Access Key [None]: YOURSECRETKEY
     Default region name [None]: us-east-1
     Default output format [None]: json
   ```
4. run `terraform init`

## Assumptions 
You need to have 2 profiles configured for aws `cloudfront` and `s3`which has access to cloudfront and s3 respectively.

It assumes you have an SSL/TLS certificate in AWS Certificate Manager (ACM) in the account you use for cloudfront if you would like to use an alternate domain for cloudfront.

If you don't have a certificate then you can just not provide input for alternate domain and certificate, at the end it will give a cloudfront domain instead.

This was made with the assumption that it will be used on empty AWS accounts therefore it creates all the resources it needs (except the certificate since it's not possible)
## How to use
1. Update `terraform.tfvars` as needed, if you provide alternate domain then you must also provide certificate ARN otherwise it will be ignored and no alternate domain will be used.
2. run `terraform plan` to check execution plan and if all is good then proceed
3. run `terraform apply` and then write yes
4. Execution will display cloudfront distribution domain name at the end, please wait 5 - 10 minutes while CF distribution gets deployed.
5. If you have configured alternate domain name, Please configure a CNAME record to point to CloudFront Distribution domain
6. :tada:

## Structure 
1. `include` Contains static files, in this case only 1 file 
2. `modules` Includes current project modules
   1. `aws-cloudfront` A module to create cloudfront distribution & CF origin identity to be used with s3
   2. `aws-s3` A module to create s3 bucket, grant access to the bucket to CF origin identity and upload index file in `include` in the root of the project
3. `main.tf` Calls modules to create cloudfront distribution & s3 bucket
4. `outputs.tf` Defines cloudfront distribution domain name output
5. `providers.tf` Defines aws providers for different AWS profiles
6. `variables.tf` Defines variables
7. `versions.tf` Defines required provider and version
8. `terraform.tfvars` contains values for variables

## What to improve
There wasn't a lot of details on how it should look like, but I would
1. Add Route 53 support to automatically generate certificate for an already existing domain in Route 53
2. Add a lot more variables to the modules to make it more reusable in different scenarios, but I figured no need to do that unless a case comes up