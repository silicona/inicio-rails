require "rails_helper"
# Dos formas de TDD
# Top-down
# 	Desde el usuario: Features -> controllers -> models

# bottom-up
# 	Desde el codigo de bajo nivel: Models -> Controllers -> Features

# http://www.betterspecs.org/es/
RSpec.describe "An Example Group with a metadata variable", :foo => 17 do
   context 'and a context with another variable', :bar => 12 do 
      
      it 'can access the metadata variable in the context block' do |example|
        expect(example.metadata[:foo]).to eq(17) 
        expect(example.metadata[:bar]).to eq(12) 
        example.metadata.each do |k,v|
         	puts "#{k}: #{v}"
        end
      end		
   end 
end 

describe UsuariosController do
  #render_views
  describe "GET 'index'" do
    describe "for non-signed-in users" do
      it "redirects to login page" do
        visit :index
        response.should redirect_to(signin_path)
        flash[:notice].should match(/sign in/i)
      end
    end
    describe "for signed-in users" do
      #login_user

      before(:each) do
        get :index
      end

      it "is successful" do
        response.should be_success
      end

      it "has the right title" do
        response.should have_selector("title", :content => "Users")
      end
    end
  end
end

# feature test
RSpec.feature 'Usuario crea una microentrada'  do
	scenario "Accede al site" do
		visit root_path
		#click_button "Acceder"
		click_link "Acceder"
		visit acceder_path

		expect(page).to have_content "Password"
		fill_in "sesiones_email", with: "example@railstutorial.org"
		fill_in "sesiones_password", with: "password"
		click_button "Acceder"
		visit usuario_path

		expect(page).to eq "usuarios/show"

	end

	scenario 'Escribe la microentrada y la ve en pantalla' do
		visit root_path
		click_link "Acceder"
		visit acceder_path

		fill_in 'microentrada_contenido', with: "This is my first post"
		click_button "crear post"

		expect(page).to_have_content "this is my first post"
	end
end

#model
RSpec.describe 'Usuario' do
	# Class methods(prefix with .)
	describe '.active' do
		it 'returns only active users' do
			active_user = create(:usuario, activado: true)
			non_active_user = create(:usuario, activado: false)
			resultado = Usuario.activado

			expect(resultado).to eq [active_user]
		end
	end

	# Class methods (prefix with #)
	describe '#name' do
		it 'returns the concadenated first and last name' do
			user = build(:usuario, first_name: "paul", last_name: "ttheti")

			expect(user.name).to eq "paul ttheti"
		end
	end
end

# controllers
describe 'SesionesController' do
	describe 'Post #create' do
		context 'when password is invalid' do
			it 'renders the page with error' do
				user = create(:user)

				post :create, session: { email: user.mail, password: 'invalid'}

				expect(response).to render_template(:new)
				expect(flash[:notice]).to match(/^Email and password dont match/)
			end
		end

		context 'when password is valid' do
			it 'sets the user in the session and redirects the to their dashboard' do
				user = create(:user)

				post :create, session: { user: user.mail, password: user.password }

				expect(response).to redirecto_to '/dashboard'
				expect(controller.current_user).to eq user
			end
		end
	end
end

class Dog
   attr_reader :good_dog, :has_been_walked 
   
   def initialize(good_or_not)
      @good_dog = good_or_not 
      @has_been_walked = false 
   end 
   
   def walk_dog 
      @has_been_walked = true 
   end 
end 

describe Dog do 
   def create_and_walk_dog(good_or_bad)
      dog = Dog.new(good_or_bad)
      dog.walk_dog
      return dog 
   end 
   
   it 'should be able to create and walk a good dog' do
      dog = create_and_walk_dog(true)
      
      expect(dog.good_dog).to be true
      expect(dog.has_been_walked).to be true 
   end 
   
   it 'should be able to create and walk a bad dog' do 
      dog = create_and_walk_dog(false)
      
      expect(dog.good_dog).to be false
      expect(dog.has_been_walked).to be true 
   end 
end