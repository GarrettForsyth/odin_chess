require 'redis'

$redis = Redis::Namespace.new("odin_chess", :redis => Redis.new)
