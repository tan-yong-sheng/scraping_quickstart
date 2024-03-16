# Use another python version in Gitpod Workspace

# Reference: https://www.gitpod.io/docs/introduction/languages/python
# You could use `gitpod/workspace-full` as well.
FROM gitpod/workspace-python
RUN pyenv install 3.10 \
    && pyenv global 3.10