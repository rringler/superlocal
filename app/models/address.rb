class Address
	require 'net/http'
	require 'rexml/document'

	attr_reader :address2, :city, :state, :zip5

	def initialize(args=nil)
		@address2 = args[:address2] || nil
		@city     = args[:city]     || nil
		@state    = args[:state]    || nil
		@zip5     = args[:zip5]     || nil
	end

	def to_slug
		@slug ||= slug_from_standardized_address(standardized_address)
	end

	private

	def standardized_address
		uri = URI('http://production.shippingapis.com/ShippingAPITest.dll')
		uri.query = URI.encode_www_form({ API: 'Verify', XML: to_xml })

		response = Net::HTTP.get_response(uri)
		xml_data = REXML::Document.new(response.body)

		unless xml_data.elements["//Error"]
			{ address1: nil,
				address2: xml_data.elements["//Address/Address2"].text,
				city:     xml_data.elements["//Address/City"].text,
				state:    xml_data.elements["//Address/State"].text,
				zip5:     xml_data.elements["//Address/Zip5"].text,
				zip4:     xml_data.elements["//Address/Zip4"].text }
		end
	end

	def to_xml
		%Q(<AddressValidateRequest USERID="#{usps_api_username}">
		 	<Address ID="0">
				<Address1></Address1>
				<Address2>#{@address2}</Address2>
				<City>#{@city}</City>
				<State>#{@state}</State>
				<Zip5>#{@zip5}</Zip5>
				<Zip4></Zip4>
			</Address>
		</AddressValidateRequest>).split(/\r?\n/).map { |x| x.strip }.join
	end

	def usps_api_username
		@usps_api_username ||= ENV['USPS_API_USERNAME']
	end

	def slug_from_standardized_address(address)
		if address
			slug = "#{address[:address2]}-#{address[:zip5]}"

			# Perform transliteration to replace non-ascii characters with an ascii
	    # character
	    slug = slug.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n, '').to_s
	    
	    # Remove single quotes from input
	    slug.gsub!(/[']+/, '')

	    # Replace any non-word character (\W) with a space
	    slug.gsub!(/\W+/, ' ')
	    
	    # Remove any whitespace before and after the string
	    slug.strip!
	    
	    # All characters should be downcased
	    slug.downcase!
	    
	    # Replace spaces with dashes
	    slug.gsub!(' ', '-')
	    
	    # Return the resulting slug
	    slug
	  end
	end
end
