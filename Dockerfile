#temporary container to feed into nginx instances
FROM node:alpine as builder 
WORKDIR /app
COPY package.json .
RUN npm install
COPY . . 
RUN npm run build

#import folder for production => /app/build

FROM nginx
#copy over all builder phase into nginx instance for hosting
#command : COPY static-web-directory-to-show-to-world location-static-file-will-be-located-on-nginx
# received specific result from temporary container which builder folder 
COPY --from=builder /app/build /usr/share/nginx/html