require 'calabash-android/management/adb'
require 'calabash-android/operations'

Before do |scenario|
  `#{adb_command} logcat -c` # clears logcat output
  start_test_server_in_background
end

After do |scenario|
  `mkdir '#{scenario.feature.name}'`
  `mkdir '#{scenario.feature.name}/#{scenario.name}'`
  `#{adb_command} logcat -v time 2>&1 -d > '#{scenario.feature.name}/#{scenario.name}/sys_log.txt'`  
  
  embed('sys_log.txt', 'text/plain', 'sys_log.txt')
  if scenario.failed?
    screenshot_embed
  end
  shutdown_test_server
end