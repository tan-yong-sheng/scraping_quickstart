from aws_cdk import (
    # Duration,
    Stack,
    # aws_sqs,
    aws_lambda,
    aws_apigateway,
    Duration,
    LayerVersion,
    Runtime
)
from constructs import Construct


class AwsLambdaDockerPythonStack(Stack):
    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        # queue = aws_sqs.Queue(
        #    self, "AwsLambdaDockerPythonQueue",
        #    visibility_timeout=Duration.seconds(300),
        # )

        lambda_function = aws_lambda.DockerImageFunction(
            self, "DockerFunc",
                memory_size=512,
                code = aws_lambda.DockerImageCode.from_image_asset("./image"),
                timeout = Duration.seconds(10),
                architecture = aws_lambda.Architecture.X86_64
        )

        aws_apigateway.LambdaRestApi(
            self, "Endpoint",
            handler=lambda_function,
        )

        
