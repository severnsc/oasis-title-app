class Search < ApplicationRecord
  belongs_to :user

  def title_orders
    @title_orders ||= find_title_orders
  end

  private

  def find_title_orders
    TitleOrder.joins(:buyers, :property).where(conditions).distinct
  end

  def buyer_name_conditions
    ["buyers.first_name LIKE ? OR buyers.last_name LIKE ?", buyer_name, buyer_name] unless buyer_name.blank?
  end

  def street_conditions
    ["addresses.street LIKE ?", "%#{street}%"] unless street.blank?
  end

  def city_conditions
    ["addresses.city LIKE ?", "%#{city}%"] unless city.blank?
  end

  def state_conditions
    ["addresses.state LIKE ?", "%#{state}%"] unless state.blank?
  end

  def zip_conditions
    ["addresses.zip LIKE ?", "%#{zip}%"] unless zip.blank?
  end

  def conditions
    [conditions_clauses.join(' AND '), *conditions_options]
  end

  def conditions_clauses
    conditions_parts.map { |condition| condition.first }
  end

  def conditions_options
    conditions_parts.map { |condition| condition[1..-1] }.flatten
  end

  def conditions_parts
    private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
  end
end
