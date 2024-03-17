from aws_cdk import (
    # Duration,
    Stack,
    aws_sqs,
    aws_lambda
)
from constructs import Construct

class AwsLambdaDockerPythonStack(Stack):

    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        # The code that defines your stack goes here

        # example resource
        queue = aws_sqs.Queue(
            self, "AwsLambdaDockerPythonQueue",
            visibility_timeout=Duration.seconds(300),
        )

        lambda_function = aws_lambda.AwsLambdaDockerPythonStack(
            self, "AwsLambdaDockerPythonStack",
            memory_size = 512,
            timeout = Duration.seconds(10),
            code = aws_lambda.Code.from_asset("./image"),
            runtime = aws_lambda.Runtime.PYTHON_3_10,
            architecture = aws_lambda.Architecture.X86_64,

        )
    