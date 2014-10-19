create:
	rails new ttt
	cd ttt && cp ../deploy.rb ./config/
	cd ttt && git init .
	cd ttt && git add .
	cd ttt && git ci -m "init"

deploy:
	cd ttt && mina setup
	cd ttt && mina deploy

clean:
	rm -rf ttt
	rm -rf deployed_to
