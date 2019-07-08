# TTW Static Hosting Demo

An example on how to setup static hosting on an S3 bucket using CircleCI, Terraform and CloudFront.

Sample deployed app: [http://d247l0crx8r2wi.cloudfront.net/](http://d247l0crx8r2wi.cloudfront.net/)

| Username | Password |
| -------- | -------: |
| admin    |      ttw |


## Prerequisites

- CircleCI account linked to a GitHub account
- AWS account
- [AWS CLI Installed](https://docs.aws.amazon.com/cli/latest/userguide/install-macos.html)
  - Check with `aws --version`
- [Terraform installed locally](https://brewinstall.org/install-terraform-on-mac-with-brew/) 
  - Check with `terraform --version`


## Sequence

__Reset repo__

1. Clone this repo, remove `.git` folder and initialise as a new repo

__Set up Terraform__

2. Create an S3 bucket to handle Terraform state
- You can use the CLI: 

```shell
aws s3api create-bucket --bucket **BUCKET_NAME** --region eu-west-2 --create-bucket-configuration LocationConstraint=eu-west-2 
```
- Or you can just create a new S3 bucket via the AWS dashboard
3. Add the S3 bucket name from step 2 to Terraform config at `infrastructure/config.tf` ([commit](https://github.com/tyreer/tyree-ttw-static-hosting-demo/commit/c9da0ebc33146c3ae47db616a033ebb6a139ad11))
4. Ensure you have AWS credentials availible to your CLI ([docs](https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/setup-credentials.html))
 
 - You may have to create a user from the [IAM dashboard in AWS](https://console.aws.amazon.com/iam/home#/home)
 - Then create a `credentials` file in the system folder `./aws` located in your user root directory. The text will look like this:

 ```shell
[this-is-any-name-i-want]
aws_access_key_id=ZXZXZXZXZXZXXZXZXZXZ
aws_secret_access_key=kjhsdkjfhdsfSDFsdfjkhksdjfhb1213dlkhj
 ```

5. Run `export AWS_PROFILE=this-is-any-name-i-want` in your terminal and then `make terraform-init` locally to generate and upload our Terraform project's "[remote state backend](https://www.terraform.io/docs/state/remote.html)" 

__Set up CircleCI__

6. Push your repo up to the GitHub account CircleCI is connected to
7. Add your repo as a CircleCI project 
8. On that project, add your AWS keys as environment variables ([see docs here](https://circleci.com/docs/2.0/deployment-integrations/#aws))

__Deploy__

9. Our `.circleci/config.yml` is currently set up to only run tasks on the `develop` branch, so create and checkout that branch.
10. In the `S3/frontend.tf` file, add any name you like for the resource name + S3 bucket that will serve your static app. ([commit](https://github.com/tyreer/tyree-ttw-static-hosting-demo/commit/9fc03fd26fb975cd74c12e3a801319e7ea69e461))
11. Push your commits up to GitHub and check CircleCI dashboard for job progress


## Auth

Need to setup domain name and ssl cert to be able to allow cloudfront to use them for deployment.
Add arns to terraform variables and uncomment code in terraform cloudfront

CloudFront can deployed without these and will be given a default cname record.

Create Auth Lambda  
cd authentication  
yarn init  
yarn deploy  
GO to AWS Console LAMBDA and get arn number for lambda  
Put in terraform variable FRONTEND_LAMBDA_FUNCTION_ASSOCIATION

## Installing

### Frontend

```shell
cd frontend
yarn install
yarn start
```
