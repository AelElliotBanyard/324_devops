FROM node:latest
WORKDIR /app
RUN git clone https://github.com/AelElliotBanyard/324_devops.git
RUN git checkout docker
RUN npm build
EXPOSE 3000
ENTRYPOINT ["npm", "run", "start"]
