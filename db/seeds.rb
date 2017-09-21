# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Usuario.create!(nombre: "Usuario de ejemplo",
								email: "example@railstutorial.org",
								password: 'password',
								password_confirmation: 'password',
								admin: true,
								activado: true,
  							activado_en: Time.zone.now )

Usuario.create!(nombre: "Segundo usuario",
								email: "vertederonuclear@gmail.com",
								password: 'password',
								password_confirmation: 'password',
								activado: true,
  							activado_en: Time.zone.now )

Usuario.create!(
	nombre: "La virgen de Fátima",
	email: "railsprueba0@gmail.com",
	password: "password",
	password_confirmation: "password",
	activado: true,
	activado_en: Time.zone.now
)

Usuario.create!(
	nombre: "Oso Yogi",
	email: "railsprueba1@gmail.com",
	password: "password",
	password_confirmation: "password",
	activado: true,
	activado_en: Time.zone.now
)

99.times do |n|
	nombre = Faker::Name.name
	email = "ejemplo#{n+1}@railstutorial.org"
	password = "password"
	Usuario.create!(nombre: nombre,
									email: email,
									password: password,
									password_confirmation: password,
									activado: true,
  								activado_en: Time.zone.now )
end

	## Microentradas

usuarios = Usuario.order(:created_at).take(6)
50.times do
	#contenido = Faker::HitchhikersGuideToTheGalaxy.marvin_quote
	#contenido = Faker::Lovecraft.sentence(4,3)
	contenido = Faker::Lorem.sentence(4, false, 3)
	usuarios.each { |usuario| usuario.microentradas.create!(contenido: contenido) }
end

	## Relaciones

usuarios = Usuario.all
usuario = usuarios.first
siguiendo = usuarios[2..50]
seguidores = usuarios[3..40]
siguiendo.each { |seguido| usuario.seguir(seguido) }
seguidores.each { |seguidor| seguidor.seguir(usuario) }