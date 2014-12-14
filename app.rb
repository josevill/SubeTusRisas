# Inclusion de dependencias
require "cuba"
require "cuba/render"
require "ohm"

# Inclusion de DB Contenido principal
require_relative "models/content"
require_relative "models/comments"

Cuba.plugin(Cuba::Render)
Cuba.use Rack::Session::Cookie, secret: "foobar" # Cookie

Ohm.redis = Redic.new("redis://127.0.0.1:6379") # Conexion a DB REDIS

# Definicion de Vistas/Contenido
Cuba.define do
  @page = {
    title: "Sube tus risas - Upload de Imagenes divertidas"
  }

  on get, "imagen/:id" do |id|
    res.write(view("imagen", imagenes: Upload_main[id]))
  end

	# Creacion de contenido nuevo por POST a desde /views/newcontent.erb
  on post, "contenido-nuevo" do
  	subida = Upload_main.create(
  			titulo: req.POST["titulo"],
  			poster: req.POST["poster"],
        link: req.POST["link"]
  		)
  	res.redirect("imagen/#{subida.id}")
  end

  on get, "contenido-nuevo" do
    res.write(view("newcontent"))
  end

  on get, "acerca-de" do
  	res.write(view("about"))
  end

  on root do
    res.write (view("home", imagenes: Upload_main.all))
  end
end