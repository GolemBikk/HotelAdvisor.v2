class UserSerializer < ActiveModel::Serializer
  attributes :id, :authentication_token,
             :first_name, :last_name, :email, :gravatar

  def gravatar
    size = 80
    gravatar = Digest::MD5::hexdigest(object.email).downcase
    "http://gravatar.com/avatar/#{gravatar}.png?s=#{size}"
  end
end
