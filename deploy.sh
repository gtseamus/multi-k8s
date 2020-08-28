docker build -t gtseamus/multi-client:latest -t gtseamus/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gtseamus/multi-server:latest -t gtseamus/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gtseamus/multi-worker:latest -t gtseamus/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push gtseamus/multi-client:latest
docker push gtseamus/multi-server:latest
docker push gtseamus/multi-worker:latest

docker push gtseamus/multi-client:$SHA
docker push gtseamus/multi-server:$SHA
docker push gtseamus/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gtseamus/multi-server:$SHA
kubectl set image deployments/client-deployment server=gtseamus/multi-client:$SHA
kubectl set image deployments/worker-deployment server=gtseamus/multi-worker:$SHA
