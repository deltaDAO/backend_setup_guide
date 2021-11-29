# Ocean Backend setup guide
Step-by-step guide to deploy your own Ocean backend.
## Requirements
To deploy your own Ocean backend, you need the following tools:
- docker a guide in how to install docker is available at: https://docs.docker.com/engine/install/ubuntu/
- minikube You can get a guide in how to install minikube at: https://v1-18.docs.kubernetes.io/docs/tasks/tools/install-minikube/
## Installing the Backend
If you have cloned this repository, access it with cd backend_setup_guide.
Then you can run the setup script with: ./setup.sh.
The script will guide you through the setup steps that need to be done.
If you want to start again, you can use the rest.sh script to get the initial state again.
## After installation
After installation the backend will listen on following ports:
- Aquarius Port:                5000
- Elasticsearch Port:           9200
- Ocean Provider Port:          8030
- Ocean Operator Service Port:  8050
## Add certificate and place some nginx/haproxy/etc
If you want your Oceanprotocol stack to be public setup. You could setup a nginx/haproxy/etc. 
