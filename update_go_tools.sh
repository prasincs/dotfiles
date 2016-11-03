#!/bin/bash
go get -u -v github.com/nsf/gocode
if [[ "$(go version)" =~ "go version go1.5" ]]; then echo cannot get golint; else go get -u -v github.com/golang/lint/golint; fi
go get -u -v github.com/rogpeppe/godef
go get -u -v github.com/lukehoban/go-outline
go get -u -v sourcegraph.com/sqs/goreturns
go get -u -v github.com/tpng/gopkgs
go get -u -v github.com/cweill/gotests/...
go get -u -v golang.org/x/tools/cmd/guru
go get -u -v github.com/newhook/go-symbols
go get -u -v golang.org/x/tools/cmd/goimports
