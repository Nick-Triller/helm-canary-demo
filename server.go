package main

import (
	"flag"
	"fmt"
	"log"
	"net/http"
)

// Version is the version of the application
var Version = "Will be overwritten at build time"

func main() {
	listenAddress := flag.String("a", "localhost:8080", "listen address to serve on")
	flag.Parse()
	http.HandleFunc("/", indexHandler)
	log.Printf("Starting server on %s\n", *listenAddress)
	log.Fatal(http.ListenAndServe(*listenAddress, nil))
}

func indexHandler(w http.ResponseWriter, req *http.Request) {
	fmt.Fprintf(w, "<h1>Version: %s</h1>", Version)
}
