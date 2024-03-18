This is a work in progress

new idea - deploy chrome driver as layer to aws lambda https://awstip.com/build-deploy-reusable-lambda-layers-using-aws-cdk-dd1fd47454c3

[![AWS CDK application](https://i.stack.imgur.com/kgE0H.png)](https://stackoverflow.com/questions/67855703/the-difference-between-a-stack-and-construct-in-aws-cdk)

Further Reference:

Reference:
1. Step 1 - Create an AWS user with programmatic access: https://www.simplified.guide/aws/iam/create-programmatic-access-user

2. AWS CDK Workshop https://cdkworkshop.com/30-python/20-create-project/300-structure.html

2. Step 2 - How to Run a Python Docker Image on AWS Lambda https://www.youtube.com/watch?v=wbsbXfkv47A

3. AWS CDK and Python | Step by Step Tutorial
https://d2yeaxazqu9ejn.cloudfront.net/2022/06/24/aws-cdk-and-python-step-by-step-tutorial/?amp=1

4. YouTube Tutorial for AWS CDK: https://www.youtube.com/watch?v=D4Asp5g4fp8&t=3159s) -> aws iac generator: generate AWS CloudFormation template for existing resources, then use cdk migrate to transform it to the script... 

5. How AWS is Making It Easier To Convert to IaC/CDK https://www.youtube.com/watch?v=zyT4y-rfu7s

6. AWS IAM Core Concepts You NEED to Know https://www.youtube.com/watch?v=_ZCTvmaPgao

7. Setting Up an AWS CDK Project with Minimum IAM Access: A Step-by-Step Guide https://www.linkedin.com/pulse/setting-up-aws-cdk-project-minimum-iam-access-guide-kundu/

8. Multi Factor Authentication (MFA) With AWSCLI https://www.youtube.com/watch?v=mNfIh5tUVpg

9. Understand AWS L1, L2, L3 construct https://medium.com/devops-techable/understand-constructs-in-aws-cdk-and-learn-how-to-build-your-first-l3-constructs-for-reusing-your-62e60b9a8da8

1. Run Selenium in AWS Lambda for UI testing https://cloudbytes.dev/snippets/run-selenium-in-aws-lambda-for-ui-testing

1. Automate Web Scraping Using Python, AWS Lambda, Amazon S3 and Amazon EventBridge CloudWatch https://medium.com/@vinodvidhole/automate-web-scraping-using-python-aws-lambda-amazon-s3-amazon-eventbridge-cloudwatch-c4c982c35fa7

---

## Documentation on how to add python packages to AWS Lambda

If you're using python 3.10 runtime:

`pip install -r requirements.txt -t python/lib/python3.10/site-packages`

then zip the `python/` directory folder

then upload the zip files as a layer of AWS Lambda: https://docs.aws.amazon.com/lambda/latest/dg/adding-layers.html 


However, take note that unzipped package size has to be less than 250MB to deploy to the layer of AWS Lambda. 

---

1. Running Selenium on AWS Lambda
 https://kuanbutts.com/2022/10/27/docker-selenium-chromium-lambda/

1. How do I create a Lambda layer using a simulated Lambda environment with Docker? https://repost.aws/knowledge-center/lambda-layer-simulated-docker


1. Deploy a Docker built Lambda function with AWS CDK https://dev.to/wesleycheek/deploy-a-docker-built-lambda-function-with-aws-cdk-fio

2. How to Deploy a Python Lambda Using AWS CDK? https://dev.to/wesleycheek/deploy-a-docker-built-lambda-function-with-aws-cdk-fio

1. Selenium Web Scraping Project From Scratch using Replit and AWS Lambda https://www.youtube.com/watch?v=FcW-AXsirBE

1. Learn How to Develop Web Scrappers and scrape things at Massive Scale Using Lambdas Lab 18 with code with Selenium: https://www.youtube.com/watch?v=VoAKT00yZZk

1. Web scraping using AWS Lambda and API Gateway:
https://www.lucasamos.dev/articles/lambdaapigateway

1. How to Create a FREE Custom Domain Name for Your Lambda URL - A Step by Step Tutorial https://dev.to/omarcloud20/how-to-create-a-free-custom-domain-name-for-your-lambda-url-a-step-by-step-tutorial-47jl

1. Is serverless cheaper for your use case? Find out with this calculator. https://medium.com/serverless-transformation/is-serverless-cheaper-for-your-use-case-find-out-with-this-calculator-2f8a52fc6a68
