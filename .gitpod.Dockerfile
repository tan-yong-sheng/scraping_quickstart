# Use another python version in Gitpod Workspace

# Reference: https://www.gitpod.io/docs/configure/workspaces/workspace-image
# Reference 2: https://simonemms.com/blog/2022/04/30/using-a-non-ubuntu-base-image-in-gitpod
# Reference 3: https://github.com/gitpod-io/gitpod/issues/7459
# Reference 4: Install chrome broswer on Docker to use Selenium https://github.com/omkarcloud/gitpod-selenium

FROM gitpod/workspace-full

# Part 1: Set up AWS Cloud Development Kit

USER root

## use python 3.10
RUN pyenv install 3.10 \
    && pyenv global 3.10

## Install necessary packages
RUN sudo install-packages \
        python3-pip \
        nodejs \
        npm \
        git \
        git-lfs \
        curl \
        zip \
        unzip

## Install AWS CLI v2
### refer https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
        && unzip awscliv2.zip \
        && sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin \
        && rm -rf awscliv2.zip \
        && rm -rf ./aws

## Install AWS CDK and aws-cdk-lib module
RUN npm install -g aws-cdk

## Copy the requirements file into the container
COPY requirements.txt .
## Install Python dependencies from requirements.txt
RUN pip3 install -r requirements.txt

# Part 2: Install Chrome browser on Docker, as it's required by Selenium
# refer https://github.com/omkarcloud/gitpod-selenium/blob/master/Dockerfile

## Install Chrome dependencies
RUN apt-get update && apt-get install -y \
    wget \
    gnupg2 \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Add the Google Chrome repository
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list

# Install Google Chrome
RUN apt-get update && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

USER gitpod

# Add the Chrome as a path variable
ENV CHROME_BIN=/usr/bin/google-chrome

# Check if Chrome was installed successfully
RUN google-chrome --version
