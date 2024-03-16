# Use another python version in Gitpod Workspace

# Reference: https://www.gitpod.io/docs/configure/workspaces/workspace-image
# Reference 2: https://simonemms.com/blog/2022/04/30/using-a-non-ubuntu-base-image-in-gitpod

FROM gitpod/workspace-base

# Set environment variable for nodejs
ENV NODE_VERSION=18

# Install necessary packages
RUN sudo install-packages \
        python3.10 \
        python3-pip \
        npm \
        git \
        git-lfs \
        curl \
        zip \
        unzip

# Install nvm and node.js
LABEL dazzle/layer=lang-node
LABEL dazzle/test=tests/lang-node.yaml
RUN curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | PROFILE=/dev/null bash \
  && bash -c ". .nvm/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && npm install -g typescript yarn node-gyp" 

# Install AWS CLI v2: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
       && unzip awscliv2.zip \
       && sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin \
       && rm -rf awscliv2.zip \
      && rm -rf ./aws

# install AWS CDK
RUN sudo npm i -g aws-cdk

# Copy the requirements file into the container
COPY requirements.txt .
# Install Python dependencies from requirements.txt
RUN pip install -r requirements.txt
