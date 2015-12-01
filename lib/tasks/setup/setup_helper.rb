module SetupHelper
  def setup_solr(env, port, blacklight_jetty_version, blacklight_core_name, blacklight_core_version)
    blacklight_dir = "blacklight_#{env}"
    if !File.directory?(blacklight_dir)
      sh "mkdir #{blacklight_dir}"

      # Download the Base blacklight installation
      puts "Downloading Blacklight #{blacklight_jetty_version}"
      blacklight = RestClient.get "https://github.com/projectblacklight/blacklight-jetty/archive/v#{blacklight_jetty_version}.tar.gz"
      untar blacklight, blacklight_dir, 'blacklight-jetty'

      # Download the Umbra Blacklight Core and symlink it into the core blacklight installation
      puts "Downloading Blacklight #{blacklight_core_name}"
      blacklight_core = RestClient.get "https://github.com/UMNLibraries/#{blacklight_core_name}/archive/#{blacklight_core_version}.tar.gz"
      untar blacklight_core, blacklight_dir, 'blacklight_core'

      # Symlink the downloaded core into the jetty solr directory
      symlink_core(blacklight_dir, blacklight_jetty_version, blacklight_core_name, blacklight_core_version)
    else
      puts "Blackglight already downloaded"
    end
    puts "Starting blacklight on port #{port}"
    # Start Blackglight
    sh "cd #{blacklight_dir}/blacklight-jetty-#{blacklight_jetty_version}; nohup java -jar start.jar -Djetty.port=#{port} &"
  end

  def symlink_core(blacklight_dir, blacklight_jetty_version, blacklight_core_name, blacklight_core_version)
    sh "ln -nsf #{Rails.root}/#{blacklight_dir}/#{blacklight_core_name}-#{blacklight_core_version}/  #{Rails.root}/#{blacklight_dir}/blacklight-jetty-#{blacklight_jetty_version}/solr/#{blacklight_core_name}"
    sh "cp #{Rails.root}/lib/tasks/setup/solr.xml #{Rails.root}/#{blacklight_dir}/blacklight-jetty-#{blacklight_jetty_version}/solr"
  end

  def untar(data, dir, filename)
    open("#{dir}/#{filename}.tar.gz", 'wb')  do |file|
      file.write(data)
      file.close()
    end
    sh "cd #{dir}; tar -xzvf #{filename}.tar.gz"
  end

end