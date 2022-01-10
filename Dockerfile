FROM node:16-alpine as builder

WORKDIR /app
COPY package.json .

RUN npm install

COPY . .

RUN npm run build

############################## the second from statment finishes the forst stage
#/app/build <-- all the important stuff

FROM nginx
#expose is a way to communicate 
EXPOSE 80
## copy from another phase, which folder, to where
COPY --from=builder /app/build usr/share/nginx/html

# requires the use of -p to specify port trafficing...