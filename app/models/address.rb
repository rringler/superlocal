class Address
  attr_reader :address2, :city, :state, :zip5

  def initialize(args={})
    @address2 = args[:address2] || nil
    @city     = args[:city]     || nil
    @state    = args[:state]    || nil
    @zip5     = args[:zip5]     || nil
  end
end
