# Copyright 2014 N3TWORK, Inc.
#
# Licensed under Apache 2.0 - see the LICENSE file

# Select git revision for building druid from source (we can only deploy tagged releases)
default[:druid][:version] = '0.8.0' # Specifies build filename, may need '-rc1' suffix, etc
default[:druid][:repository] = 'https://github.com/optimizely/druid.git' # Note this is not the official druid repo
default[:druid][:revision] = 'druid-' +  default[:druid][:version] # Release 0.8.0

# Installation
default[:druid][:user] = "druid"
default[:druid][:group] = "druid"
default[:druid][:src_dir] = "/opt/druid_src"
default[:druid][:install_dir] = "/opt/druid"
default[:druid][:config_dir] = "/etc/druid"
default[:druid][:log_path] = "/var/log/druid"

#################################################################
# Configuration follows. Settings with ':properties' make their #
# way into configuration files                                  #
#################################################################

#Common configuration
default[:druid][:log_to_syslog] = 1
default[:druid][:properties]["druid.host"] = node[:ipaddress]
default[:druid][:timezone] = "UTC"
default[:druid][:encoding] = "UTF-8"
default[:druid][:java_opts] = "-Xmx1G"
default[:druid][:extra_classpath] = ""
common_monitors = ["com.metamx.metrics.JvmMonitor"]
default[:druid][:properties]["druid.monitoring.monitors"] = common_monitors
default[:druid][:properties]["druid.emitter"] = "logging"
default['java']['jdk_version'] = '7'

# Dynamic configuration
default[:druid][:zookeeper_role] = nil # Chef role for Zookeeper IP lookup

# Node-type-specific configuration. In cases of conflict,
# the type-specific config overrides the common config.

# Broker specific config
default[:druid][:broker][:properties]["druid.service"] = "broker"
default[:druid][:broker][:properties]["druid.port"] = 8080
default[:druid][:broker][:properties]["druid.monitoring.monitors"] = common_monitors + ["io.druid.client.cache.CacheMonitor"]
default[:druid][:broker][:properties]["druid.cache.type"] = "local"
default[:druid][:broker][:properties]["druid.cache.sizeInBytes"] = 2**20 * 100
default[:druid][:broker][:properties]["druid.broker.cache.useCache"] = "true"
default[:druid][:broker][:properties]["druid.broker.cache.populateCache"] = "true"
default[:druid][:broker][:properties]["druid.broker.cache.unCacheable"] = []


# Coordinator specific config
default[:druid][:coordinator][:properties]["druid.service"] = "coordinator"
default[:druid][:coordinator][:properties]["druid.port"] = 8081

# Realtime specific config
default[:druid][:realtime][:properties]["druid.service"] = "realtime"
default[:druid][:realtime][:properties]["druid.port"] = 8082
default[:druid][:realtime][:properties]["druid.monitoring.monitors"] = common_monitors + ["io.druid.segment.realtime.RealtimeMetricsMonitor"]

# Historical specific config
default[:druid][:historical][:properties]["druid.service"] = "historical"
default[:druid][:historical][:properties]["druid.port"] = 8083
default[:druid][:historical][:properties]["druid.monitoring.monitors"] = common_monitors + ["io.druid.client.cache.CacheMonitor","io.druid.server.metrics.HistoricalMetricsMonitor"]
default[:druid][:historical][:properties]["druid.cache.type"] = "local"
default[:druid][:historical][:properties]["druid.cache.sizeInBytes"] = 2**20 * 100
default[:druid][:historical][:properties]["druid.historical.cache.useCache"] = "true"
default[:druid][:historical][:properties]["druid.historical.cache.populateCache"] = "true"
default[:druid][:historical][:properties]["druid.historical.cache.unCacheable"] = []

# Overlord specific config
default[:druid][:overlord][:properties]["druid.service"] = "overlord"
default[:druid][:overlord][:properties]["druid.port"] = 8084

# Indexer specific config
default[:druid][:indexer][:properties]["druid.port"] = 8085

# Middle manager specific config
default[:druid][:middlemanager][:properties]["druid.service"] = "middlemanager"
default[:druid][:middleManager][:properties]["druid.port"] = 8086



