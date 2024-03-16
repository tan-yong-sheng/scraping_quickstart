# Use another python version in Gitpod Workspace

# Reference: https://www.gitpod.io/docs/configure/workspaces/workspace-image

FROM gitpod/workspace-base

# Install necessary packages
RUN sudo install-packages \
        python3.10 \
        python3-pip \
        node \
        npm \
        git \
        git-lfs \
        curl \
        zip \
        unzip

# Install nvm 
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.35.2/install.sh | bash \
        && export NVM_DIR="$HOME/.nvm" \
RUN [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
RUN [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # this loads nvm bash_completion
RUN nvm install v18.19.1 # install node js version 18, so that it is compatible with AWS CDK

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
