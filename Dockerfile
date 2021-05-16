FROM python:3.7

ARG GIT_REVISION=main

EXPOSE 8444
EXPOSE 8555

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN git clone -b ${GIT_REVISION} --single-branch https://github.com/Chia-Network/chia-blockchain.git .
RUN pip install -e .

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
