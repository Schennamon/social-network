# Out of the box, every Redis instance supports 16 databases.
# The default database is 0 but you can change that to any number from 0-15.
# Each database provides a distinct keyspace, independent from the others.
# Use FLUSHDB to flush the current database.
#
# 15 - $redis, for general purpose in the code
# 13 - $redis, for test
# 1  - sidekiq
#

$redis = Redis.new(db: Rails.env.test? ? 13 : 15)
