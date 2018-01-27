class CreatePositionTransitions < ActiveRecord::Migration[5.2]
  def change
    create_table :position_transitions do |t|

      t.timestamps
    end
  end
end
