FROM golang:latest as build
RUN go get -v github.com/sirupsen/logrus && \
    go get -v github.com/mailgun/mailgun-go
COPY . /code
WORKDIR /code
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /idlerpg-checker .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=build /idlerpg-checker /idlerpg-checker
RUN echo "v0.0.1" >> .version
ARG domain
ARG api_key
ENV MG_API_KEY=$api_key
ENV MG_DOMAIN=$domain
ENTRYPOINT ["/idlerpg-checker"]