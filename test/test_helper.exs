:application.start :inets

server_root = '#{Path.absname("test/sample_pages")}'

test_server_config = [
  port: 9090,
  server_name: 'hound_test_server',
  server_root: server_root,
  document_root: server_root,
  bind_address: {127, 0, 0, 1}
]

{:ok, pid} = :inets.start(:httpd, test_server_config)

IO.inspect "Stopping Hound and restarting with options for test suite..."
:ok = :application.stop(:hound)

Hound.Supervisor.start_link([
  driver: System.get_env("WEBDRIVER") || "phantomjs",
  app_port: 9090
])

System.at_exit fn(_exit_status) ->
  IO.puts "Deleting test fixtures..."
  File.rm_rf("priv/static/screens")
  :ok = :inets.stop(:httpd, pid)
end

ExUnit.start()

IO.puts "Instantiating test fixtures..."
File.cp_r("priv/static/fixtures/screens", "priv/static/screens")
