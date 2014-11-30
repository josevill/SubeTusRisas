class Upload_comments < Ohm::Model
	attribute :content
	reference :imagen, :Upload_main
end