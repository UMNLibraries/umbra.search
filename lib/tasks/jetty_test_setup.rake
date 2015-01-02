BLACKLIGHT_JETTY_VERSION = '4.10.0'

namespace :jetty_test_setup do
  desc "Download, unpack and run Blacklight Jetty"
  task :run do
    data = RestClient.get "https://github.com/projectblacklight/blacklight-jetty/archive/v#{BLACKLIGHT_JETTY_VERSION}.tar.gz"
    open('blacklight-jetty.tar.gz', 'wb')  do |file|
      file.write(data)
      file.close()
    end
    sh "tar -xzvf blacklight-jetty.tar.gz"
    sh "cd blacklight-jetty-#{BLACKLIGHT_JETTY_VERSION}; java -jar start.jar -Djetty.port=8888 &"
  end
end
