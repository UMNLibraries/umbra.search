config = YAML.load_file(Rails.root + 'config/aws.yml')[Rails.env]
raise "Unable init AWS connection" unless config.is_a? Hash
AWS.config(config)