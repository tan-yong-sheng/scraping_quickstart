FROM public.ecr.aws/lambda/python:3.10

# Copy requirements.txt 
COPY requirements.txt ${LAMBDA_TASK_ROOT}

# Install the specified packages
RUN pip install -r requirements.txt

# copy all files in ./src
COPY src/* ${LAMBDA_TASK_ROOT}

# set the CMD to your handler
CMD ["main.handler"]

