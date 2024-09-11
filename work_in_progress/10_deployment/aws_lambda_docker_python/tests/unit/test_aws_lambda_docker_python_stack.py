import aws_cdk as core
import aws_cdk.assertions as assertions

from aws_lambda_docker_python.aws_lambda_docker_python_stack import AwsLambdaDockerPythonStack

# example tests. To run these tests, uncomment this file along with the example
# resource in aws_lambda_docker_python/aws_lambda_docker_python_stack.py
def test_sqs_queue_created():
    app = core.App()
    stack = AwsLambdaDockerPythonStack(app, "aws-lambda-docker-python")
    template = assertions.Template.from_stack(stack)

#     template.has_resource_properties("AWS::SQS::Queue", {
#         "VisibilityTimeout": 300
#     })
