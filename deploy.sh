docker build -t sanlobs/multi-client:latest -t sanlobs/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sanlobs/multi-server:latest -t sanlobs/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sanlobs/multi-worker:latest -t sanlobs/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sanlobs/multi-client:latest
docker push sanlobs/multi-server:latest
docker push sanlobs/multi-worker:latest

docker push sanlobs/multi-client:$SHA
docker push sanlobs/multi-server:$SHA
docker push sanlobs/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sanlobs/multi-server:$SHA
kubectl set image deployments/client-deployment client=sanlobs/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sanlobs/multi-worker:$SHA