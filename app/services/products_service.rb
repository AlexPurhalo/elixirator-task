class ProductsService
  # The average age of users with management role
  def self.managers_age; User.where(role: 'management').average(:age); end

  # The first three oldest users expect admins
  def self.oldest_users; User.where.not(role: 'admin').order(:age)[0...3]; end

  # The products updated by employees during last week but not today, order by updating
  def self.updated_products
    updated_products = Product
                           .where.not(updated_by: nil)
                           .where('updated_at >= ?', 1.week.ago)
                           .where.not('updated_at >= ?', Time.zone.now.beginning_of_day)
                           .order(updated_at: :desc)

    employees, employees_products = User.where(role: 'employee'), Array.new

    for i in 0...updated_products.length
      for j in 0...employees.length
        if updated_products[i].updated_by === employees[j].id
          employees_products.push(updated_products[i])
        end
      end
    end
    
    return employees_products
  end

  # Shows the different output of Products for differents users types
  def self.sorted_by_roles(user); Product.order(user.nil? || user.role != 'admin' ? :title : :price); end
end