class CreateTitleOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :title_orders do |t|
      t.references :property, references: :addresses
      t.references :buyers_agent, references: :agents
      t.references :sellers_agent, references: :agents
      t.references :lender
      t.string :title_type
      t.string :closing_type
      t.string :buyers_agent_commission
      t.string :sellers_agent_commission
      t.boolean :survey_requested, default: true

      t.timestamps
    end

    create_table :buyers_title_orders, id: false do |t|
    	t.references :buyer, index: true
    	t.references :title_order, index: true
    end
  end
end
