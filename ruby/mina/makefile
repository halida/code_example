create:
	rails new ttt
	cd ttt

	mina init
	cp ../deploy.rb ./config/
	git init .
	git add .
	git ci -m "init"

deploy:
	mina setup
	mina deploy

clean:
	rm -rf ttt
	rm -rf deployed_to
