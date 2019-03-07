set -e

eval `ssh-agent`
export GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no"
echo $GITHUB_DEPLOY_KEY | base64 -d > _the_key
chmod 600 _the_key
ssh-add _the_key
git config --global user.name "Deploy from CI"
git config --global user.email ""
