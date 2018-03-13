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

### Run through a manual test

Run this command to start a test container:

```bash
docker run --rm -d -v $(pwd):/opt -v $(pwd)/gpg:/srv/salt/gpg -h salt-master-sandbox --name salt-master-sandbox simplyadrian/allsalt:centos_master_2017.7.2
```

Let's shell into the container and verify our state is in place:

```bash
docker exec -it salt-master-sandbox bash

# ensure the state is in the right place
ls /srv/salt/gpg
```

Now we can run the state and verify a key was generated:

```bash
# run the state
salt-call -l debug state.apply gpg

# verify the key was generated
salt-call gpg.list_keys gnupghome='/etc/salt/gpgkeys'
```

Exit the shell and kill the container

```bash
docker kill salt-master-sandbox
```


## <a name='setup-harness'></a> Implement the Test Harness

1. Fork this repository
2. Follow the install instructions in the `formula-test-harness` [docs](https://github.com/intuitivetechnologygroup/formula-test-harness#-install)
3. Start a virtualenv and run the setup:

```bash
pip install -U virtualenv
virtualenv .venv
source .venv/bin/activate
make setup
```

4. Run the centos test:

```bash
make test-centos_master_2017.7.2
```
