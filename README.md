# sf.rcp.aws-docker
Safe Recipes - Step 1: Deploy a plain docker container on AWS 

### Clone repo

$ git clone git@github.com:philskaroulis/sf.rcp.aws-docker.git

$ cd sf.rcp.aws-docker

$ npm install

### Build docker image

$ docker build -t sf.rcp.aws-docker .

$ docker images --filter reference=sf.rcp.aws-docker

$ docker run -p 80:8080 sf.rcp.aws-docker

### Test access from the browser

http://localhost/

### Create an AWS ECR repo

$ export AWS_PROFILE=_aws_profile_

$ aws ecr create-repository --repository-name sf.rcp.aws-docker

```
{
    "repository": {
        "repositoryArn": "arn:aws:ecr:us-east-1:aws_account_id:repository/sf.rcp.aws-docker",
        "registryId": "aws_account_id",
        "repositoryName": "sf.rcp.aws-docker",
        "repositoryUri": "aws_account_id.dkr.ecr.us-east-1.amazonaws.com/sf.rcp.aws-docker",
        "createdAt": 1519420109.0
    }
}
```

### Tag the docker image, log into AWS ECR & push the image up

$ docker tag sf.rcp.aws-docker aws_account_id.dkr.ecr.us-east-1.amazonaws.com/sf.rcp.aws-docker

$ $(aws ecr get-login --no-include-email);

$ docker push aws_account_id.dkr.ecr.us-east-1.amazonaws.com/sf.rcp.aws-docker

$ aws ecr list-images --repository-name sf.rcp.aws-docker

```
{
    "imageIds": [
        {
            "imageDigest": "sha256:ed0...",
            "imageTag": "latest"
        }
    ]
}
```

### Launch an ec2 instance.

• Configure the security groups by adding HTTP/Anywhere

• Create a new private key (*.pem), download it & move it to ~/.ssh

### Connect to the EC2 instance:

$ mv /location/of/downloaded/pem/sfrcp.pem ~/.ssh

$ chmod 400 ~/.ssh/sfrcp.pem

$ ssh -i ~/.ssh/sfrcp.pem aws-user@aws_public_dns

### Prepare instance

$ sudo yum update -y

$ sudo yum install -y docker

$ sudo usermod -aG docker aws-user

$ sudo service docker start

$ sudo docker --version

### Configure AWS cli

Copy aws user's AWS Access Key ID & AWS Secret Access Key

$ aws configure

```
AWS Access Key ID [None]: aws_access_key_id
AWS Secret Access Key [None]: aws_secret_key_id
Default region name [None]: us-east-1
Default output format [None]: json
```

### Log into AWS ECR & pull the image down

$ aws ecr get-login --no-include-email;

$ sudo docker login -u AWS -p eyJw... https://aws_account_id.dkr.ecr.us-east-1.amazonaws.com

$ sudo docker pull aws_account_id.dkr.ecr.us-east-1.amazonaws.com/sf.rcp.aws-docker:latest

$ sudo docker run -p 80:8080 aws_account_id.dkr.ecr.us-east-1.amazonaws.com/sf.rcp.aws-docker:latest

### Test access from the browser

http://aws_public_dns/

*Woohoo!!!*


