working_directory ""
worker_processes 4
listen "/var/run/unicorn/jrf_digital_unicorn.sock", backlog: 64
pid "/var/run/unicorn/jrf_digital_unicorn.pid"
stderr_path "/var/log/jrf_digital_unicorn.stderr.log"
stdout_path "/var/log/jrf_digital_unicorn.stdout.log"
