FROM node:latest
WORKDIR /app
RUN git clone --branch docker https://github.com/AelElliotBanyard/324_devops.git
RUN npm build
EXPOSE 3000
ENTRYPOINT ["npm", "run", "start"]
