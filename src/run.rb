require './app_worker'
require 'time'
require 'date'
aw = AppWorker.new 'config.yml'
#aw.init_dst_dir
#aw.init_git
aw.do_commits aw.gen_commits_dates

