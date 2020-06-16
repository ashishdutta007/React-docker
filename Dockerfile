# stage: 1
# pull base node image, for further cmds instructions
FROM node:13.12.0-alpine as react-build
# # Working directory
WORKDIR /app
# # copy everything into workdir /app
COPY . ./
# # install dependenceies from package.json
RUN yarn
# # build app artifacts in /app/build
RUN yarn build

# stage: 2 - the prod env
FROM nginx:alpine

# copy build artifacts generated in stage-1 into nginx where app will run
COPY nginx.conf /etc/nginx/conf.d/default.conf
# COPY /build /usr/share/nginx/html
COPY --from=react-build /app/build /usr/share/nginx/html

# app is running inside our docker container.
EXPOSE 80
# run server when container starts/run.
CMD ["nginx", "-g", "daemon off;"]


# Docker image configuration - Dockerfile
# Deploy application
# 1. Build docker image. - docker build . -t react-docker
# 2. Run container - docker run -p 8000:80 react-docker

