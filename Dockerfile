FROM node:latest
WORKDIR /app
RUN git clone --single-branch --branch docker https://github.com/AelElliotBanyard/324_devops.git
RUN npm run build
EXPOSE 3000
ENTRYPOINT ["npm", "run", "start"]
