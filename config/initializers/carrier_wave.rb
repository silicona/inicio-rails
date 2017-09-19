if Rails.env.production?
	CarrierWave.configure do |config|
		config.fog_credentials = {
				# Configuracion para Amazon S3
			:provider => "AWS",
			:aws_access_key => ENV['S3_ACCESS_KEY'],
			:aws_secret_access_key => ENV['S3_SECRET_KEY']
		}
		congif.fog_directory = ENV['S3_BUCKET']
	end
end