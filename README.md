# SaltStack Meetup Demo (3/13/2018)


## <a name='problem'></a> The Problem

I started developing a new salt formula and I need to test it...

* in an isolated environment.
* in a ci/cd tool such as travis.
* run a series of pytests.
* run an interactive test sandbox


## <a name='solution'></a> A Solution

There are many ways to solve this problem. This demo will cover the [formula-test-harness](https://github.com/intuitivetechnologygroup/formula-test-harness) option.
This test harness utilizes [allsalt](https://github.com/simplyadrian/allsalt) to spin up salt master/minion containers.


## <a name='example-formula'></a> Example Formula

This demo is using a trimmed down version of the [gpg-formula](https://github.com/meganlkm/gpg-formula).


Run this command to start a test container:

```bash
docker run --rm -d -v $(pwd):/opt -v $(pwd)/gpg:/srv/salt/gpg -h salt-master-sandbox --name salt-master-sandbox simplyadrian/allsalt:centos_master_2017.7.2
```

Now we want to shell into the container and run the state:

```bash
docker exec -it salt-master-sandbox bash

# ensure the state is in the right place
ls /srv/salt/gpg

# run the state
salt-call -l debug state.apply gpg

# verify the key was generated
salt-call gpg.list_keys gnupghome='/etc/salt/gpgkeys'
```

Exit the shell and kill the container

```bash
docker kill salt-master-sandbox
```
