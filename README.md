[![dockerfile runner badge](https://api.travis-ci.com/stasmihailov/dockerfile-runner.svg?branch=master)](https://travis-ci.com/github/stasmihailov/dockerfile-runner)
[![latest release](https://img.shields.io/badge/dynamic/json?label=latest&query=tag_name&url=https%3A%2F%2Fapi.github.com%2Frepos%2Fstasmihailov%2Fdocker-build-and-run%2Freleases%2Flatest)](https://github.com/stasmihailov/docker-build-and-run/releases/latest)

### Dockerscript 

Builds an image and runs container from Dockerfile via `docker script` command

### Basic Usage
```shell script
docker script from ubuntu
```
"from ubuntu" is a valid Dockerfile; therefore, this command runs a container of
a latest Ubuntu release image and attaches a tty to it; you can `<Ctrl-D>` to stop and remove both container and image

### Installation
- from Ubuntu PPA:
```shell script
add-apt-repository ppa:babochenko/ppa
apt-get update
apt-get install dockerscript
```
- from sources:
```shell script
sudo ./gradlew installBuildDependencies
./gradlew assemble
sudo ./gradlew install
```

### Motivation

This plugin is an elementary effort to try make docker more accessible for basic prototyping. Some of prototyping use cases might be:
- testing out some script / functionality in an isolated environment before running it locally
- executing same Dockerfile in different Linux distributions to verify that it works on each of them

This plugin tries to make such simple tasks doable in as few lines of code as possible

While you could always use a simple shell script which combines `docker build` and `docker run` with additional resource cleanup commands, this workflow is not very transferable - it would be better to have a single reusable plugin

*(I believe that tools like this one might make Docker a casual tool rather than a strictly devops tool, which is what
it's generally considered to be, at least from my experience)*

### Extended Examples

`docker script` command can be run in a directory containing a `Dockerfile`, just like `docker build` (execution results
are presented as comments):
```shell script
echo "FROM alpine
CMD echo Dockerfile executed on $(uname)" > Dockerfile

docker script .
# Dockerfile executed on Linux
```

Also `docker plugin` can execute Docker commands from stdin...
```shell script
docker script << 'EOF'
    from alpine
    RUN echo 'in RUN'
    CMD echo 'in CMD'
EOF
# in RUN
# in CMD
```

... or from string input:
```shell script
docker script "
    from alpine
    RUN echo 'in RUN'
    CMD echo 'in CMD'"
# in RUN
# in CMD
```

following command allocates a TTY in container and lets you execute arbitrary commands:
```shell script
docker script from ubuntu
```

Also, you could run single dockerfile on different distributions:
```shell script
for linux in alpine ubuntu debian 'vcatechnology/linux-mint'; do
    echo "executing Dockerfile in ${linux}"
    docker script "
        from ${linux}
        CMD uname -r"
done
```
