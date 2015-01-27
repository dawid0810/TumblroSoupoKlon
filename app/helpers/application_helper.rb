module ApplicationHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s + "/fields", f: builder)
    end
    link_to(name, '#', class: 'add_fields', data: {id: id, fields: fields.gsub('\n', '')})
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
end