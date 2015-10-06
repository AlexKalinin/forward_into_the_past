require 'fileutils'
require 'net/http'
require 'nokogiri'

class AppWorker
  def initialize(cnf_path)
    require 'yaml'
    @cnf = YAML.load_file (cnf_path)
  end


  def init_dst_dir
    if Dir.exist? @cnf['dst']
      # FileUtils.rmtree
      print "Directory #{@cnf['dst']} already exists. Deleting..."
      FileUtils.rm_r @cnf['dst'], :force => true
      puts ' ok'
    end

    Dir.mkdir @cnf['dst']
    puts "Created directory: #{@cnf['dst']}"
  end

  def init_git
    Dir.chdir @cnf['dst']
    puts 'Initialization of git repository...'
    [
        "git init #{@cnf['dst']}",
        "git config user.name \"#{@cnf['git_name']}\"",
        "git config user.email \"#{@cnf['git_email']}\"",
    ].each do |c|
      puts "Executing command: #{c}"
      `#{c}`
    end

    puts '    done.'
  end

  def do_commits(arr_dates)
    Dir.chdir @cnf['dst']
    fname = File.join(@cnf['dst'], @cnf['tgt_file_name'])
    arr_dates.each do |date|
      open(fname, 'w') do |f|
        f.puts(date.to_s)
      end

      [
          "GIT_COMMITTER_DATE=\"#{date}\"",
          'git add .',
          "git commit --date=\"#{date}\" -am \"Hacking date: #{date}\" ",
      ].each do |c|
        puts "Executing command: #{c}"
        puts `#{c}`
      end
    end
  end #def



  # def get_random_text
  #   html_page = Net::HTTP.get(URI('http://randomtextgenerator.com'))
  #   doc = Nokogiri::XML(html_page)
  #   doc.xpath('//*[@id="generatedtext"]').map do |elem|
  #     return elem.children.to_s
  #   end
  # end


  def gen_commits_dates
    year = 2015
    fist_month = 1
    last_mount = 9
    begin_work_at_hour = 9
    end_work_at_hour = 18
    min_commits_per_day = 3
    max_commits_per_day = 10

    commit_dates = []
    fist_month.upto last_mount do |m|#mothes
      max_day_in_month = Date.new(year, m, -1).mday
      1.upto max_day_in_month do |day|
        process_date = Date.new(year, m, day)
        begin
          #puts "Processing date 2015-#{m}-#{day}:"
          hours = []
          rand(min_commits_per_day..max_commits_per_day).downto 1 do
            hours << rand(begin_work_at_hour..end_work_at_hour)
          end
          hours.sort!.each do |h|
            commit_dates << DateTime.new(year, m, day, h, rand(0..59), rand(0..59))
          end
        end unless process_date.sunday? #we didn't work at sunday :)
      end
    end

    commit_dates
  end

end #AppWorker