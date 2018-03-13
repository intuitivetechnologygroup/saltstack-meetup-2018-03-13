PWD = $(shell pwd)

sandbox:
	docker run --rm -d -v $(PWD):/opt -v $(PWD)/gpg:/srv/salt/gpg -h salt-master-sandbox --name salt-master-sandbox simplyadrian/allsalt:centos_master_2017.7.2
