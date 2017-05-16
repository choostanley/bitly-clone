require 'securerandom'
class Url < ActiveRecord::Base 
	validates :original_url, presence: true, uniqueness: true
	validates :shorten_url, presence: true, uniqueness: true

	# This is Sinatra! Remember to create a migration!
	def Url.shorten
		return SecureRandom.urlsafe_base64(4)
		
	end

	def set_count
		self.count ||=0
	end

	def increment_count
		self.count +=1
	end

	def original_url= url_str
	  unless url_str.blank?
	    unless url_str.split(':')[0] == 'http' || url_str.split(':')[0] == 'https'
	        url_str = "http://" + url_str
	    end
	  end  
	  write_attribute :original_url, url_str
	end

end
