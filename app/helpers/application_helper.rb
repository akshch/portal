# frozen_string_literal: true
# ApplicationHelper
module ApplicationHelper
  # def tags
  #   Tag.all.collect{ |tag| [tag.name, tag.id] }
  # end

  def user_avatar(user, size=40)
    if user.avatar.attached? 
      user.avatar.variant(resize: "#{size}x#{size}!")
    else 
      gravatar_image_url(user.email, size: size)
    end
  end
end

  

