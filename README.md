This is a basic ansible deploy for launching icecast2 servers in AWS. It also sets up domain names using route53 and elastic load balancing. This allows us to do things like forward https requests to http on the servers, making surecure icecast streaming simple.


To deploy, you will need the following packages: 

* [boto](https://github.com/boto/boto)
* [ansible](http://docs.ansible.com/ansible/intro_installation.html)

You will also need your AWS credentials as boto uses these when talking to AWS,

    export AWS_SECRET_ACCESS_KEY='...'
    export AWS_ACCESS_KEY_ID='...'

## Mac OS X ##
Note on Mac OS you should install homebrew and then install python. This lets you install pip through a user modifiable python installation, which will prevent headaches. See [this](http://apple.stackexchange.com/questions/209572/how-to-use-pip-after-the-os-x-el-capitan-upgrade).


```
#!bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install python
pip install boto ansible etc.
```


Ansible
=======
Our ansible deployment is written for one environment,

  1. Production

And in each of those environments we have three sets of plays,

  1. Launch - this is where we "turn on" our servers in the cloud
  2. Provision - this is where we install all the base packages we need
  3. Deploy - this is the deployment of any customized things

Once an environment has 1) Launched and been 2) Provisioned, you only need to 3) Deploy for the changes to be live.

### Tags ###

All of our plays are in a separate playbook for each environment. We use tags to different environments and plays. For example,

  * deploy: deploys 
  * launch: launches servers in AWS for the staging environment
  * provision: installs base packages


Remote Instances
================

To deploy a remote production instance,

    ansible-playbook -i inventory/ec2.py --vault-id vault.sh --private-key=~/.ssh/yourkey.pem production.yml


Once the instances have been launched and provisioned, it's only necessary to run the code with the following tags,


**Production:**

    ansible-playbook -i inventory/ec2.py --vault-id vault.sh --private-key=~/.ssh/yourkey.pem production.yml -t deploy


Ansible Vault
================
We store sensitive information for this deployment in an ansible vault.

To decrypt an encrypted file,

    ansible-vault decrypt env_vars/vault.yml 

To encrypt a file,

    ansible-vault encrypt env_vars/vault.yml

For security reasons we're not storing that file in the repo. Instead we include a template which must be filled out by the user.
