module SetupHelper
  def setup_jetty(env, port, blacklight_jetty_version, blacklight_core_umbra_version)
    blacklight_dir = "blacklight_#{env}"
    if !File.directory?(blacklight_dir)
        sh "mkdir #{blacklight_dir}"
        # Download the Base blacklight installation
        blacklight = RestClient.get "https://github.com/UMNLibraries/blacklight-jetty-dpla/archive/v#{blacklight_jetty_version}.tar.gz"
        open("#{blacklight_dir}/blacklight-jetty.tar.gz", 'wb')  do |file|
          file.write(blacklight)
          file.close()
        end
        sh "cd #{blacklight_dir}; tar -xzvf blacklight-jetty.tar.gz"

        # Download the Umbra Blacklight Core and symlink it into the core blacklight installation
        blacklight_core_umbra = RestClient.get "https://github.com/UMNLibraries/blacklight-core-umbra/archive/v#{blacklight_core_umbra_version}.tar.gz"
        open("#{blacklight_dir}/blacklight-core-umbra.tar.gz", 'wb')  do |file|
          file.write(blacklight_core_umbra)
          file.close()
        end
        sh "cd #{blacklight_dir}; tar -xzvf blacklight-core-umbra.tar.gz"
        sh "ln -nsf #{Rails.root}/#{blacklight_dir}/blacklight-core-umbra-#{blacklight_core_umbra_version}/  \
        #{Rails.root}/#{blacklight_dir}/blacklight-jetty-dpla-#{blacklight_jetty_version}/solr/blacklight-core-umbra"
        sh "cp #{Rails.root}/lib/tasks/setup/solr.xml #{Rails.root}/#{blacklight_dir}/blacklight-jetty-dpla-#{blacklight_jetty_version}/solr"
    else
        puts "Blackglight already downloaded"
    end
    puts "Starting blacklight on port #{port}"
    # Start Blackglight
    sh "cd #{blacklight_dir}/blacklight-jetty-dpla-#{blacklight_jetty_version}; java -jar start.jar -Djetty.port=#{port}"
  end

end