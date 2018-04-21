class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :book_copies

  def author
    instance_options[:without_serializer] ? object.author : AuthorSerializer.new(object, without_serializer: true)
  end
end
