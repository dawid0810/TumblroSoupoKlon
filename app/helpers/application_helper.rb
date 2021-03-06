module ApplicationHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s + "/fields", f: builder, np: true)
    end
    link_to(name, '#', class: 'add_fields btn btn-info', data: {id: id, fields: fields.gsub('\n', '')})
  end

  def order_stuff(post)
    stuff = []
    post.notes.each do |n|
      stuff << n
    end
    post.images.each do |i|
      stuff << i
    end
    stuff.sort { |x, y| x["order"] <=> y["order"] }
  end

  def show(stuff)
    rendered = ""
    stuff.each do |s|
      rendered += render(s.class.name.downcase.pluralize + "/show", s: s)
    end
    rendered.html_safe
  end

  def get_username
    username = "Guest"
    username = current_user.username if current_user
    username
  end

  def get_username_with_caret
    '<span class="glyphicon glyphicon-user" aria-hidden="true"></span> ' + get_username + " <b class='caret'></b>"
  end

  def get_login_logout_link
    link = link_to('Login', new_user_session_path)
    link = link_to('Logout', destroy_user_session_path, :method => :delete) if current_user
    link
  end

  def get_profile_link
    link = link_to('Register', new_user_registration_path)
    link = link_to('Profile', '/user/' + current_user.username) if current_user
    link
  end

  def get_followed_link
    link = link_to('Followed', new_user_registration_path)
    link = link_to('Followed', '/followed') if current_user
    link
  end

  def get_followers_link
    link = link_to('Followers', new_user_registration_path)
    link = link_to('Followers', '/followers') if current_user
    link
  end

  def get_repost_link(post)
    link = link_to('Repost', new_user_registration_path, class: "btn btn-success")
    link = link_to('Repost', '/repost/' + post.id.to_s, class: "btn btn-success repost_button btn-sm", remote: true) + link_to('+', '/repost/' + post.id.to_s,
                   class: "btn btn-success repost_button btn-sm", remote: true,
                   data: { toggle: "modal", target: "#repostModal"}) if current_user
    link
  end

  def get_repost_button(post)
    '<div class="btn-group">' + get_repost_link(post) + '</div>'
  end

  def require_permission(post)
    current_user and (current_user.admin? or post.user_id == current_user.id)
  end
end