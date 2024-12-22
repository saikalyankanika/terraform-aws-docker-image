# terraform-aws-docker-image
- image that can be used to run terraform modules to create resoruces on aws
- image posses ```aws-cli, python3, terraform```

### HOW TO BUILD THIS IMAGE WITH DOCKER FILE
- run the below command in powershell or CLI by having docker desktop or container runtime up and running :

     ```docker build --build-arg PRODUCT=terraform --build-arg VERSION=<Terraform_version> -t test-terra:lat . ``` 

### How to pull and run the image on to machine
- run the below command in powershell or CLI by having docker desktop or container runtime up and running :

    ```docker run -it saikalyankanika/aws-provision-terraform-python```
- to have volume binding use this by entering the location where you want to mount  : (in powershell or linux cli)

    ```docker run -it -v ${PWD}:/src saikalyankanika/aws-provision-terraform-python```

- to have volume binding use this by entering the location where you want to mount: (in windows CMD)

    ```docker run -it -v %cd%:/src saikalyankanika/aws-provision-terraform-python```




### How to connect to aws account 
 step-1:
 - can run ```aws configure``` by entering the bash mode on container and give the  access_key adn secret key 

 step-2:

- by storing these access key and secret key in the location ```/root/.aws/credentials``` and confu=igure to aceess those appropriately and terraform also can use that by defauld as the ENV variable ```AWS_SHARED_CREDENTIALS_FILE``` is set to that path , so that terraform can use that .