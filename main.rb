require 'sinatra'
require 'securerandom'

post '/upload' do
  name = upload params[:file][:tempfile] 
  "#{request.base_url}/i/#{name}"
end

get '/i/:file' do |file|
  @file = file
  haml "%img{ src: \"/#{@file}\"}" 
end

def upload(file)
  gen_name = SecureRandom.urlsafe_base64(6)
  return if file.size > 400000000
  FileUtils.cp(file.path, File.join(settings.public_folder, gen_name))
  gen_name 
end

