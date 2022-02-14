# litecoin 0.18.1

This repository contains info on how to build a litecoin container in docker, run as a stateful set.


## Requirements

* Docker
* kubectl

## Dockerfile
Docker multistage was used as I didn't want to install everything during the build process on the image that's going to 
run in kubernetes.

```
make build
```

## litecoin-statefulset.yaml

* namespace `litecoin` doesnt exist
* storageClassName: standard exist

#### Additional info

* Tried using runAsUser and fsGroup to make sure a user i created was used however I wasn't able to get the litecoin 
  container to start in minikube k8s, something to do with ot having permission to the folder, I tried to assign 
  ownership to the user I created using `chown` however this failed
* I tested it in Minikube to verify the K8s StatefulSet
* Resources - 256MB memory should be enough for litecoin

## CI
Note: I wasn't able to get the ci server running in minikube and I tried this for jenkins and concourse, I didn't have 
enough time to find out why.
TODO:
* figure out why jenkins server and concourse servers are not working in minikube in order to test ci.


# Text manipulation program
located in `split_string/main.go`
Simple program that takes one string argument, with numbers in between the words, and Splits strings using a predefined 
regex function

To run:
```asciidoc
cd split_function
go run main.go "Hello! I am 1 funnyoldbat 2 chocoholic 3 team."
```

Output:
```asciidoc
  ➜ go run main.go "Hello! I am 1 funnyoldbat 2 clownface 3 team."
 funnyoldbat 
 clownface
```