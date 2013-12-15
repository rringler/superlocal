class AddressValidator
	require 'net/http'
	require 'rexml/document'

	attr_reader :address

	def initialize(address)
		@address = address
	end

	def slug
		@slug ||= address_to_slug(validated_address)
	end

	private


	def validated_address
		uri = URI('http://production.shippingapis.com/ShippingAPI.dll')
		uri.query = URI.encode_www_form({ API: 'Verify', XML: xml_request_params })

		response = Net::HTTP.get_response(uri)
		xml_data = REXML::Document.new(response.body)

		# Debug testing
		puts xml_data

		unless xml_data.elements["//Error"]
			{ address1: nil,
				address2: xml_data.elements["//Address/Address2"].text,
				city:     xml_data.elements["//Address/City"].text,
				state:    xml_data.elements["//Address/State"].text,
				zip5:     xml_data.elements["//Address/Zip5"].text,
				zip4:     xml_data.elements["//Address/Zip4"].text }
		end
	end

	def xml_request_params
		%Q(<AddressValidateRequest USERID="#{ENV['USPS_API_USERNAME']}">
			 	 <Address ID="0">
					 <Address1></Address1>
					 <Address2>#{@address.address2}</Address2>
					 <City>#{@address.city}</City>
					 <State>#{@address.state}</State>
					 <Zip5>#{@address.zip5}</Zip5>
					 <Zip4></Zip4>
				 </Address>
			 </AddressValidateRequest>).split(/\r?\n/).map { |x| x.strip }.join
	end

	def address_to_slug(address)
		return if address.nil?

		slug = "#{address[:address2]}-#{address[:zip5]}"

		# Perform transliteration to replace non-ascii characters with
	  # an ascii character
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
