FROM node:latest
WORKDIR /
RUN git clone --single-branch --branch docker https://github.com/AelElliotBanyard/324_devops.git
RUN cd 324_devops
RUN npm run build
EXPOSE 3000
ENTRYPOINT ["npm", "run", "start"]
