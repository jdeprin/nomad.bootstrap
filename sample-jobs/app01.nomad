# This declares a job named "docs". There can be exactly one
# job declaration per job file.
job "application01" {
  datacenters = ["aws-us-east-1"]
  type = "service"

  update {
    stagger      = "30s"
    max_parallel = 2
  }

  group "api" {
    count = 3
    task "wfe" {
      driver = "docker"

      config {
        image = "jdeprin/nomad.app01:0.0.3"
        port_map = {
          http = 7654
        }
      }

      # The service block tells Nomad how to register this service
      # with Consul for service discovery and monitoring.
      service {
        # This tells Consul to monitor the service on the port
        # labelled "http". Since Nomad allocates high dynamic port
        # numbers, we use labels to refer to them.
        port = "http"

        check {
          type     = "http"
          path     = "/health"
          interval = "30s"
          timeout  = "2s"
        }
      }

      # Specify the maximum resources required to run the task,
      # include CPU, memory, and bandwidth.
      resources {
        cpu    = 500 # MHz
        memory = 128 # MB

        network {
          mbits = 10

          # This requests a dynamic port named "http". This will
          # be something like "46283", but we refer to it via the
          # label "http".
          port "http" {}
        }
      }
    }
  }
}