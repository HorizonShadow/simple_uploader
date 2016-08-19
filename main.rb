require 'sinatra'
require 'securerandom'

post '/upload' do
  name = upload params[:file][:tempfile] 
  "#{request.base_url}/i/#{name}.jpg"
end

get '/i/:file.?:format?' do |file, format|
  content_type 'image/png'
  send_file File.join(settings.public_folder, file), disposition: :inline
end

def upload(file)
  gen_name = SecureRandom.urlsafe_base64(6)
  return if file.size > 400000000
  FileUtils.cp(file.path, File.join(settings.public_folder, gen_name))
  gen_name 
end

