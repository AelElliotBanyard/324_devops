FROM node:latest
WORKDIR /
RUN git clone --single-branch --branch docker https://github.com/AelElliotBanyard/324_devops.git
WORKDIR /324_devops
EXPOSE 3000
ENTRYPOINT ["npm", "run", "start"]
