package main

import (
	"context"
	"kube-go-app/handler"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/appmanch/go-commons/logging"
	"github.com/gorilla/mux"
)

var logger = logging.GetLogger()

func main() {
	r := mux.NewRouter()

	r.HandleFunc("/", handler.HomeHandler)
	r.HandleFunc("/health", handler.HealthCheck)
	r.HandleFunc("/readiness", handler.ReadinessCheck)

	srv := &http.Server{
		Handler:      r,
		Addr:         ":9191",
		ReadTimeout:  20 * time.Second,
		WriteTimeout: 20 * time.Second,
	}

	go func() {
		logger.InfoF("Starting Server")
		if err := srv.ListenAndServe(); err != nil {
			logger.ErrorF(err)
		}
	}()

	waitForShutdown(srv)
}

func waitForShutdown(srv *http.Server) {
	interruptChan := make(chan os.Signal, 1)
	signal.Notify(interruptChan, os.Interrupt, syscall.SIGINT, syscall.SIGTERM)

	<-interruptChan

	ctx, cancel := context.WithTimeout(context.Background(), time.Second*10)
	defer cancel()
	srv.Shutdown(ctx)

	logger.InfoF("Shutting Down")
	os.Exit(0)
}
