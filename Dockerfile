###################
## BUILD FOR PRODUCTION
###################
#
#FROM node:16.17.0-alpine As build
#
#WORKDIR /usr/src/app
#
#COPY --chown=node:node package*.json ./
#
## Install app dependencies using the `npm ci` command instead of `npm install`
#RUN npm ci
#
#COPY --chown=node:node . .
#
## Run the build command which creates the production bundle
#RUN npm run build
#
## Set NODE_ENV environment variable
#ENV NODE_ENV build
#
#USER node
#
## Start the server using the production build
#CMD [ "npm","run", "start:prod" ]



###################
# BUILD FOR PRODUCTION
###################

#FROM node:16.17.0-alpine As build
#
#WORKDIR /usr/src/app
#
#COPY --chown=node:node package*.json ./
#
#RUN npm ci
#
#COPY --chown=node:node . .
#
#RUN npm run build
#
#USER node
#
####################
## PRODUCTION
####################
#
#FROM node:16.17.0-alpine As production
#
#WORKDIR /usr/src/app
#
#COPY --chown=node:node package*.json ./
#
#RUN npm ci --only=production && npm cache clean --force
#
#COPY --chown=node:node --from=build /usr/src/app/dist ./dist
#
## Set NODE_ENV environment variable
#ENV NODE_ENV production
#
#CMD [ "npm","run", "start:prod" ]







FROM node:16.17.0-alpine As development

WORKDIR /usr/src/app

COPY --chown=node:node package*.json ./

RUN npm ci --only=development

COPY --chown=node:node . .

RUN npm run build

USER node

FROM node:16.17.0-alpine as production

ENV NODE_ENV=production

WORKDIR /usr/src/app

COPY --chown=node:node package*.json ./

RUN npm ci --only=production

COPY --chown=node:node . .

COPY --chown=node:node --from=development /usr/src/app/dist ./dist

USER node

CMD [ "npm","run", "start:prod" ]
