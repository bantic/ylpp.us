require 'moneta/tyrant'
MONETA = Moneta::Tyrant.new(YAML.load_file(Rails.root.join("config","moneta.yml"))[Rails.env])