How to run Python Docker Image on AWS Lambda

Reference:
1. How to Run a Python Docker Image on AWS Lambda https://www.youtube.com/watch?v=wbsbXfkv47A
2. AWS IAM Core Concepts You NEED to Know https://www.youtube.com/watch?v=_ZCTvmaPgao
3. Setting Up an AWS CDK Project with Minimum IAM Access: A Step-by-Step Guide https://www.linkedin.com/pulse/setting-up-aws-cdk-project-minimum-iam-access-guide-kundu/
3. Multi Factor Authentication (MFA) With AWSCLI https://www.youtube.com/watch?v=mNfIh5tUVpg

-----

1. `mkdir aws_lambda_docker` 

2. 

```bash
cd aws_lambda_docker
```

3. 

```bash
cdk init app --language typescript # use typescript for this cdk application
``` 

4. write the handler


5. (Optional) run it locally on localhost
`cd image`
`docker build -t `

6. stack.ts

add type script to define aws service you want


7. set up AWS cli

`aws configure`


Create aws access key id, aws secret access key

8. Check if AWS cli is configured properly

`aws sts get-caller-identity`


---


Question: why use Docker?
- Many popular python packages use a lot platform-specific binaries or code behind the scene, and it's difficult to make these binaries working for Amazon Lambda