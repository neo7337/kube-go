package handler

import (
	"net/http"

	"github.com/appmanch/go-commons/logging"
)

var logger = logging.GetLogger()

//HomeHandler -> Base Endpoint
func HomeHandler(w http.ResponseWriter, r *http.Request) {
	query := r.URL.Query()
	name := query.Get("name")
	if name == "" {
		name = "Guest"
	}
	loger.InfoF("Received Request for %s\n", name)
	w.Write([]byte(logger.InfoF("Hello, %s\n", name)))
}

//HealthCheck -> health check
func HealthCheck(w http.ResponseWriter, r *http.Request) {
	logger.InfoF("Invoking Health checks : %s\n", r.URL.Query())
	w.WriteHeader(http.StatusOK)
}

//ReadinessCheck -> readiness check
func ReadinessCheck(w http.ResponseWriter, r *http.Request) {
	logger.InfoF("Invoking Readiness checks : %s\n", r.URL.Query())
	w.WriteHeader(http.StatusOK)
}
