# Use another python version in Gitpod Workspace

# Reference: https://www.gitpod.io/docs/configure/workspaces/workspace-image
# Reference 2: https://simonemms.com/blog/2022/04/30/using-a-non-ubuntu-base-image-in-gitpod
# Reference 3: https://nalth.is/custom-gitpod-images/
# Reference 4: https://github.com/gitpod-io/gitpod/issues/7459

FROM gitpod/workspace-base
RUN gpg --keyserver keys.openpgp.org --recv-keys BC6B641A9D1AA1277130025ED9497100C5AC1B0F

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

# Install Node.js from nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
    && . $HOME/.nvm/nvm.sh \
    && nvm install 18 \
    && nvm alias default 18 \
    && nvm use default

# Install Typescript
ENV TS_VERSION=4.4.4
RUN curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | PROFILE=/dev/null bash \
    && bash -c ". .nvm/nvm.sh \ 
    && nvm use $NODE_VERSION \
    && npm i -g typescript@$TS_VERSION"

# Install AWS CLI v2: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
        && unzip awscliv2.zip \
        && sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin \
        && rm -rf awscliv2.zip \
        && rm -rf ./aws

# Install AWS CDK for Typescript
ENV CDK_VERSION=2.1.0
RUN curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | PROFILE=/dev/null bash \
    && bash -c ". .nvm/nvm.sh \ 
    && nvm use $NODE_VERSION \
    && npm i -g aws-cdk@$CDK_VERSION"

# Copy the requirements file into the container
COPY requirements.txt .
# Install Python dependencies from requirements.txt
RUN pip install -r requirements.txt

# Ensure commands below run in the correct environment
RUN . $HOME/.nvm/nvm.sh && nvm use default && npm install -g yarn