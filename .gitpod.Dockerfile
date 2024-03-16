# Use another python version in Gitpod Workspace

# Reference: https://www.gitpod.io/docs/introduction/languages/python
# You could use `gitpod/workspace-full` as well.
FROM gitpod/workspace-python
RUN pyenv install 3.10 \
    && pyenv global 3.10

COPY requirements.txt .
RUN pip install -r requirements.txt

# Install AWS CLI v2: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
        && unzip awscliv2.zip \
        && sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin \
        && rm -rf awscliv2.zip \
        && rm -rf ./aws
