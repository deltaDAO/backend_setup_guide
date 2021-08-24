#!/bin/bash
#
# AQUARIUS
#
read -p "Please Enter OCEAN_ADDRESS:"$'\n' OCEAN_ADDRESS_KEY

#
# OPERATOR-ENGINE
#
read -p "Please Enter AWS_ACCESS_KEY_ID:"$'\n' AWS_ACCESS_KEY_ID
read -p "Please Enter AWS_SECRET_ACCESS_KEY:"$'\n' AWS_SECRET_ACCESS_KEY
read -p "Please Enter AWS_REGION:"$'\n' AWS_REGION_KEY
read -p "Please Enter AWS_BUCKET_OUTPUT:"$'\n' AWS_BUCKET_OUTPUT_KEY
read -p "Please Enter AWS_BUCKET_ADMINLOGS:"$'\n' AWS_BUCKET_ADMINLOGS_KEY

#
# PROVIDER
#
read -p "Please Enter PROVIDER_PRIVATE_KEY:"$'\n' PROVIDER_PRIVATE_KEY

read -r -p "Everything inserted right? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
     sed -i 's/OCEAN_ADDRESS_KEY/'"$OCEAN_ADDRESS_KEY"'/g' aquarius/aquarius-events-rinkeby-deployment.yaml
     sed -i 's/PROVIDER_ADDRESS_KEY/'"$OCEAN_ADDRESS_KEY"'/g' provider/provider-standard-networks-deployment-example.yaml
     sed -i 's/AWS_ACCESS_KEYID/'"$AWS_ACCESS_KEY_ID"'/g' operator-engine/operator.yml
     sed -i 's/AWS_SECRET_ACCESSKEY/'"$AWS_SECRET_ACCESS_KEY"'/g' operator-engine/operator.yml
     sed -i 's/AWS_REGION_KEY/'"$AWS_REGION_KEY"'/g' operator-engine/operator.yml
     sed -i 's/AWS_BUCKET_OUTPUT_KEY/'"$AWS_BUCKET_OUTPUT_KEY"'/g' operator-engine/operator.yml
     sed -i 's/AWS_BUCKET_ADMINLOGS_KEY/'"$AWS_BUCKET_ADMINLOGS_KEY"'/g' operator-engine/operator.yml
     sed -i 's/PROVIDER_PRIVATEKEY/'"$PROVIDER_PRIVATE_KEY"'/g' provider/provider-standard-networks-deployment-example.yaml
	    
fi



echo -e "First create following Kubernetes namespaces: ocean, ocean-operator, ocean-compute with following code:\n
1. kubectl create namespace ocean\n
2. kubectl create namespace ocean-operator\n
3. kubectl create namespace ocean-compute\n
Press RETURN if you are finished."
read return_button
clear
echo -e "Deploy Aquarius and Elasticsearch with following steps:\n
1. kubectl config set-context --current --namespace ocean\n
2. kubectl apply -f aquarius/elasticsearch-master-sts.yaml\n
3. kubectl apply -f aquarius/aquarius-events-rinkeby-deployment.yaml\n
4. kubectl apply -f aquarius/aquarius-deployment.yaml\n
5. kubectl port-forward --namespace ocean svc/elasticsearch-master 9200:9200\n
Press RETURN if you are finished for the next steps."
read return_button
clear
echo -e "Deploy operator-service with following steps:\n
1. kubectl config set-context --current --namespace ocean-operator\n
2. kubectl create -f operator-service/postgres-configmap.yaml\n
3. kubectl create -f operator-service/postgres-storage.yaml\n
4. kubectl create -f operator-service/postgres-deployment.yaml\n
5. kubectl create -f operator-service/postgresql-service.yaml\n
6. kubectl apply -f operator-service/deployment.yaml\n
When you are finished press RETURN for the next step."
read return_button
clear
echo -e "Next deploy operator-engine with these steps:\n
1. kubectl config set-context --current --namespace ocean-compute
2. kubectl apply -f operator-engine/sa.yml\n
3. kubectl apply -f operator-engine/binding.yml\n
4. kubectl apply -f operator-engine/operator.yml\n
5. kubectl create -f operator-service/postgres-configmap.yaml\n"
echo -e "If you succesfuly installed the operator-engine press RETURN."
read return_button
clear

echo -e "Expose the Operator-Service and Initialize database with the following steps:\n
1. kubectl expose deployment operator-api --namespace=ocean-operator --port=8050\n
2. kubectl -n ocean-operator port-forward svc/operator-api 8050\n
3. curl -X POST 'http://localhost:8050/api/v1/operator/pgsqlinit' -H  'accept: application/json'\n
"
echo -e "If you have initialized the database press RETURN to continue."
read return_button
clear
echo -e "Switch to namespace ocean\n 1. kubectl config set-context --current --namespace ocean\n Deploy the provider with:\n 2. kubectl apply -f provider/provider-standard-networks-deployment-example.yaml\n If you have done every single step your environment should be up and running."






