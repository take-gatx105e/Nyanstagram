module CatsHelper
  def the_first_image(cat)
    image = cat.images.order(:position)[0]

    render_cat_image(image) if image
  end

  def other_images(cat)
    buffer = "".html_safe

    cat.images.order(:position)[1..-1]&.each do |image|
      buffer << render_cat_image(image)
    end

    buffer
  end

  private
  
  def render_cat_image(image)
    content_tag(:div) do
      image_tag image.profile_cat_image.variant(resize: "550x>"),
        alt: image.alt_text,
        style: "display: block; margin: 0 auto 15px", class: "cat_image"
    end
  end
end