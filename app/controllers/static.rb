require 'byebug'

get '/' do
	puts "[Log] Getting /"
	puts "[Log] Params: #{params.inspect}"
  erb :"static/index"
end

post '/urls' do 
	#url = Url.new(original_url: params[:long_url], shorten_url: Url.shorten)
	x = Url.new
	x.original_url = params[:long_url]
	x.shorten_url = Url.shorten
	x.set_count
	if x.save
		redirect '/'
	else
		redirect '/wrong'
	end
end

get '/wrong' do
	erb :"static/wrong"
end

get '/:short_url' do
	#byebug
	url = Url.find_by(shorten_url: params[:short_url])
	url.increment_count
	url.save
	redirect url.original_url

end

