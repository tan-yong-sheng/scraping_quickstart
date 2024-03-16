# Use another python version in Gitpod Workspace

# Reference: https://www.gitpod.io/docs/configure/workspaces/workspace-image

FROM gitpod/workspace-base

# Install necessary packages
RUN sudo install-packages \
        python3.10 \
        python3-pip \
        nodejs \
        npm \
        git \
        git-lfs \
        curl \
        zip \
        unzip

# Install AWS CLI v2: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
# RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
 #       && unzip awscliv2.zip \
 #       && sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin \
 #       && rm -rf awscliv2.zip \
 #      && rm -rf ./aws

# install AWS CDK
RUN sudo npm i -g aws-cdk

# Copy the requirements file into the container
COPY requirements.txt .
# Install Python dependencies from requirements.txt
RUN pip install -r requirements.txt
