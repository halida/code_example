build:
	eval $$(minikube docker-env)
	docker build . -t halida/node-web-app
deploy:
	kubectl apply -f deploy.yml

