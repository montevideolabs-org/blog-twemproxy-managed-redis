require 'redis'
require 'benchmark'

redis = Redis.new(
  host: 'your redis endpoint',
  port: 6379,
  password: 'the password we set earlier',
  ssl: true
  )

for m in 1..5 do
  elapsed_time = Benchmark.realtime do
    for n in 1..100 do
      key = "key_#{n}"
      value = rand(1..100) # Generate a random number between 1 and 100

      # Set the value in Redis
      redis.set(key, value)

      if n % 100 == 0
        puts "Iteration: #{n*m}"
      end
    end
  end
  puts "Elapsed time: #{elapsed_time}s"
end

## Read the values
(1..1000).each do |n|
  key = "key_#{n}"

  # Read the value from Redis
  value = redis.get(key)

  puts "Value for #{key}: #{value}"
end


# Disconnect from Redis
redis.quit

