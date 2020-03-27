docker build -t irsan238/multi-client:latest -t irsan238/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t irsan238/multi-server:latest -t irsan238/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t irsan238/multi-worker:latest -t irsan238/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push irsan238/multi-client:latest
docker push irsan238/multi-server:latest
docker push irsan238/multi-worker:latest

docker push irsan238/multi-client:$SHA
docker push irsan238/multi-server:$SHA
docker push irsan238/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=irsan238/multi-client:$SHA
kubectl set image deployments/server-deployment server=irsan238/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=irsan238/multi-worker:$SHA
