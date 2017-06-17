# terraform-docker-swarm-aws

Source files used to create a VPC, bastion host, and EC2 instances that form a docker swarm mode cluster.

For more information, read the tutorial: http://ngerakines.me/2016/11/20/terraform_docker_swarm_and_aws/

## TLDR;

Follow these steps to get it up and running:

#### Create a key pair
  Log into your Amazone EC2 console.
  Then click NETWORK & SECURITY, Key Pairs, [Create Key Pairs (in us-west-2)](https://us-west-2.console.aws.amazon.com/ec2/v2/home?region=us-west-2#KeyPairs:sort=keyName)

#### Create the AMI using the packer executable

```bash
  $ packer build docker.json
```

#### Update config with new AMI
Update the ami attribute found in docker.tf and swarm.tf.


#### subnet_id and security_group_ids
Run `terraform output`
Be sure to change the subnet_id and security_group_ids attributes to the outputted vpc_subnet_a and sg_bastion values.


#### Check what it's planning to do

```bash
  $ terraform plan
```

#### Apply the plan
```bash
  $ terraform apply
```

#### Output

```bash
Outputs:

bastion_host = ec2-52-39-228-49.us-west-2.compute.amazonaws.com
sg_bastion = sg-3dd4ef46
sg_swarm = sg-4cc9f237
swarm_managers = [
      ec2-35-160-86-132.us-west-2.compute.amazonaws.com
    ]
    swarm_nodes = [
      ec2-52-43-173-34.us-west-2.compute.amazonaws.com,
      ec2-52-27-207-18.us-west-2.compute.amazonaws.com,
      ec2-34-211-196-94.us-west-2.compute.amazonaws.com
    ]
```

See if Nginx has started. Run curl agains one of the swarm nodes: `curl -vvs ec2-34-212-80-220.us-west-2.compute.amazonaws.com | head -n 10`
