#!/bin/bash

INSTANCE_ID=$(curl -s -w '\n' http://169.254.169.254/latest/meta-data/instance-id/)
EC2_AZ=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
EC2_REGION="`echo \"$EC2_AZ\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`" 
CODE_COMMIT=$(aws ec2 describe-instances --region $EC2_REGION --instance-ids $INSTANCE_ID --query "Reservations[*].Instances[*].Tags[?Key=='codecommit'].Value" --output text )
REPO_PUPPET=$(aws ec2 describe-instances --region $EC2_REGION --instance-ids $INSTANCE_ID --query "Reservations[*].Instances[*].Tags[?Key=='puppet_repo'].Value" --output text )
PUPPET_ROLE=$(aws ec2 describe-instances --region $EC2_REGION --instance-ids $INSTANCE_ID --query "Reservations[*].Instances[*].Tags[?Key=='puppet_profile'].Value" --output text )

rm -rf /etc/puppetlabs/code/environments/*

/opt/puppetlabs/puppet/bin/gem install --no-ri --no-rdoc r10k

mkdir -p /etc/puppetlabs/r10k

cat > /etc/puppetlabs/r10k/r10k.yaml <<EOF
---
:cachedir: /opt/puppetlabs/server/data/puppetserver/r10k
:sources:
  puppet:
    basedir: /etc/puppetlabs/code/environments
    remote: $REPO_PUPPET
EOF

/opt/puppetlabs/puppet/bin/r10k deploy environment production -v debug --puppetfile

echo "node default { include role::$PUPPET_ROLE }" > /etc/puppetlabs/code/environments/production/manifests/site.pp 

/opt/puppetlabs/puppet/bin/puppet apply /etc/puppetlabs/code/environments/production/manifests/site.pp