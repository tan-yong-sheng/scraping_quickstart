How to run Python Docker Image on AWS Lambda



1. Create an Aws user with programmatic access: [https://www.simplified.guide/aws/iam/create-programmatic-access-user](https://www.simplified.guide/aws/iam/create-programmatic-access-user)

- and then, create aws access key id, aws secret access key, and put as ENVIRONMENT VARIABLE

2. install AWS CLI: [https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

3. install AWS CDK: `npm install -g aws-cdk`

4. `mkdir aws_lambda_docker` 

5. ```cd aws_lambda_docker```

6. Use typescript for CDK application

```cdk init app --language typescript``` 

7. write the handler


8. (Optional) run it locally on localhost
`cd image`
`docker build -t `

9. stack.ts

add typescript to define aws service you want


10. set up AWS cli

`aws configure`



8. Check if AWS cli is configured properly

`aws sts get-caller-identity`


9.

---


Question: why use Docker?
- Many popular python packages use a lot platform-specific binaries or code behind the scene, and it's difficult to make these binaries working for Amazon Lambda