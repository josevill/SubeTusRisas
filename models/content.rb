class Upload_main < Ohm::Model
	attribute :titulo
	attribute :poster
	attribute :link
	collection :comments, :Upload_comments
end