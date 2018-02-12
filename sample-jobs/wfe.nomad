# This declares a job named "docs". There can be exactly one
# job declaration per job file.
job "boostrap-wfe" {
  datacenters = ["aws-us-east-1"]
  type = "service"

  update {
    stagger      = "30s"
    max_parallel = 2
  }

  group "webs" {
    count = 3
    task "frontend" {
      driver = "docker"

      config {
        image = "hashicorp/http-echo"
        args = [
          "-text", "Hello World!",
        ]
        port_map = {
          http = 5678
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
          path     = "/"
          interval = "10s"
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