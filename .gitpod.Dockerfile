# Use another python version in Gitpod Workspace

# Reference: https://www.gitpod.io/docs/configure/workspaces/workspace-image

ENV TZ=Asia/Kuala_Lumpur
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

FROM ubuntu:20.04

RUN apt-get update && apt-get install -yq \
        git \
        git-lfs \
        sudo \
        python3.10 \
        pip \
        nodejs \
        curl \
        zip \
        unzip \
        && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

COPY requirements.txt .
RUN pip install -r requirements.txt

# Install AWS CLI v2: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
        && unzip awscliv2.zip \
        && sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin \
        && rm -rf awscliv2.zip \
        && rm -rf ./aws
