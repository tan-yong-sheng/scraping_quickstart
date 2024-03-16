# Use another python version in Gitpod Workspace

# Reference: https://www.gitpod.io/docs/configure/workspaces/workspace-image
# Reference 2: https://simonemms.com/blog/2022/04/30/using-a-non-ubuntu-base-image-in-gitpod
# Reference 3: https://nalth.is/custom-gitpod-images/


FROM gitpod/workspace-base
RUN gpg --keyserver keys.openpgp.org --recv-keys BC6B641A9D1AA1277130025ED9497100C5AC1B0F

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

# Manually install NodeJS from nvm
ENV NODE_VERSION=14.18.2
RUN curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | PROFILE=/dev/null bash \
    && bash -c ". .nvm/nvm.sh \
        && nvm install $NODE_VERSION \
        && nvm alias default $NODE_VERSION"

# Install Typescript
ENV TS_VERSION=4.4.4
RUN curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | PROFILE=/dev/null bash \
    && bash -c ". .nvm/nvm.sh \ 
    && nvm use $NODE_VERSION \
    && npm i -g typescript@$TS_VERSION"

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

# Make node accessible from path
ENV PATH=$PATH:/home/gitpod/.nvm/versions/node/v${NODE_VERSION}/bin