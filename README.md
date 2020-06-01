## One-Line Runner of Dockerfiles 

[![dockerfile runner badge](https://api.travis-ci.com/stasmihailov/dockerfile-runner.svg?branch=master)](https://travis-ci.com/github/stasmihailov/dockerfile-runner)

Adds ability to build AND run Dockerfiles in one command via `docker script` command. Also cleans up
resources created during execution (container + image)

### Installation

You could install plugin by downloading the .deb file from latest release at [releases page](https://github.com/stasmihailov/docker-build-and-run/releases) and installing it as follows:
```shell script
# requires either root or sudo privileges
dpkg -i dockerscript_{version}.deb 
```

Or, you could build and install plugin from sources:

```shell script
# requires either root or sudo privileges
./install.sh
```

### Basic Usage
```shell script
# "from ubuntu" is a valid Dockerfile
docker script from ubuntu
# command above starts container with ubuntu and opens a tty in it
# press <Ctrl-D> to exit and remove container and temporary image
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
