module ProductsHelper
  def changer_name(id); (user = User.find(id)) && "#{user.first_name} #{user.last_name}"; end

  def archive_btn_title(archived); archived ? 'Return' : 'Archive'; end

  def show_changes?(user, params); user && user.role === 'admin' && params[:show_changes] ? true : false; end

  def product_name(title, article)
    title_arr, capitalized_title = title.split(' '), String.new

    for i in 0..title_arr.length; capitalized_title << title_arr[i].to_s + " "; end

    "#{capitalized_title}##{article}"
  end

  def product_price(price); "$#{price}"; end

  def product_class(sale); sale > 0.0 && 'sale-price'; end

  def product_with_sale(sale, price); sale > 0.0 ? "$#{price * 2}" : ''; end

  def show_archive_btn?(user); user.role != 'employee' ? true : false; end
end
