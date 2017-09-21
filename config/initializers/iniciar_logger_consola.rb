if defined?(Rails::Console)
	registrador = Logger.new(STDOUT)
		# Opciones = DEBUG, INFO, WARN, ERROR, FATAL, UNKNOWN
	registrador.level = Logger::INFO
	ActiveRecord::Base.logger = registrador
end