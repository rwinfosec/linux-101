# Linux 101 Lunch and Learn
___
This is to be used to practice topics and challenges in the Linux 101 Lunch and Learn

|username|password|
|---------|-------|
|gumby|pokey|
|root|root|
___
1. Create the docker container
```bash
make docker-build
```

2. Start the docker container
```bash
make run-local
```

3. ssh to the container on port 2222 with the user `gumby` and password `pokey`
```bash
ssh -p 2222 gumby@localhost
```

4. To stop the container
```bash
make stop-local
```