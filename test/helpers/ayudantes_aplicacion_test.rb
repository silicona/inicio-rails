require "test_helper"

class AyudantesAplicacionTest < ActionView::TestCase
	test "Ayudante tituloCompleto" do
		assert_equal tituloCompleto, 'PrimeraApp'
		assert_equal tituloCompleto('Contacto'), 'Contacto | PrimeraApp'
	end
end