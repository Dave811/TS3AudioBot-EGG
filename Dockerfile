FROM ubuntu:18.04 

#ENV DEBIAN_FRONTEND noninteractive

RUN apt update -y \
    && apt upgrade -y \
	&& apt install -y curl wget sudo apt-utils gnupg libopus-dev ffmpeg tee \
	&& sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
	&& echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list \
	&& apt-get update \
	&& apt-get -y install mono-complete

RUN useradd -m -d /home/container container

USER container
ENV HOME /home/container
ENV TERM=xterm
WORKDIR /home/container


COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
