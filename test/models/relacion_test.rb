require 'test_helper'

class RelacionTest < ActiveSupport::TestCase
  
  setup do
  	@relacion = Relacion.new(seguidor_id: usuarios(:paco).id, 
                             seguido_id: usuarios(:shilum).id)
  end

  test "Debería ser valido" do
  	assert @relacion.valid?
  end

  test "Deberia tener un seguidor" do
  	@relacion.seguidor_id = nil
  	assert_not @relacion.valid?
  end

  test "Debería tener un seguido" do
  	@relacion.seguido_id = nil
  	assert_not @relacion.valid?
  end
end
