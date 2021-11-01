#!/bin/sh

version=1_0_0

cd frontend
yarn build
cd ./build
go-bindata -o=../../src/bindata/bindata.go  -pkg=bindata -fs ./...

cd ../..

mkdir -p build

go mod download
go mod vendor
go mod verify

ls
pwd

CGO_ENABLED=0 GOOS=linux GOARCH=arm go build ./src/main.go
mv main ./build/gatewayAuth_linux_arm_$version
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build ./src/main.go
mv main ./build/gatewayAuth_linux_amd64_$version
CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build ./src/main.go
mv main ./build/gatewayAuth_darwin_amd64_$version