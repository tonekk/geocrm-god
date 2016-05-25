God.watch do |w|
  w.name = "mongodb"
  w.start = "service mongodb start"
  w.stop = "service mongodb stop"
  w.restart = "service mongodb restart"

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end
  end

  w.restart_if do |on|
    on.condition(:memory_usage) do |c|
      c.above = 500.megabytes
      c.times = [3, 5] # 3 out of 5 intervals
    end

    on.condition(:cpu_usage) do |c|
      c.above = 50.percent
      c.times = 5
    end
  end
end
