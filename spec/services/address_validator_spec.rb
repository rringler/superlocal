require 'spec_helper'

describe AddressValidator do
	describe '#slug' do
		it 'should return a slug string with the address2 & zip5' do
			address = Address.new({ address2: "1800 Cabrillo Memorial Dr.",
  													  city:     "San Diego",
  														state:    "CA",
  														zip5:     "92106" })

  	  address_validator = AddressValidator.new(address)

  	  # mocked API call with known good data
			address_validator.should_receive(:validated_address)
											 .and_return({ address1: nil,
																	   address2: "1800 CABRILLO MEMORIAL DR",
																	   city:     "SAN DIEGO",
																	   state:    "CA",
																	   zip5:     "92106",
																	   zip4:     "3601" })

			address_validator.slug.should eq("1800-cabrillo-memorial-dr-92106")
		end
	end
end
