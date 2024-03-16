# Use another python version in Gitpod Workspace

# Reference: https://www.gitpod.io/docs/introduction/languages/python
# Reference 2: https://medium.com/@pidugusundeep5/installing-packages-with-apt-get-on-gitpod-a70f0c6b1cf4

FROM gitpod/workspace-base

USER gitpod

# Install python to this workspace
RUN sudo apt-get -y install python3.10

# Install nodejs to this workspace as well
RUN sudo apt-get -y install nodejs

COPY requirements.txt .
RUN pip install -r requirements.txt

# Install AWS CLI v2: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
        && unzip awscliv2.zip \
        && sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin \
        && rm -rf awscliv2.zip \
        && rm -rf ./aws
