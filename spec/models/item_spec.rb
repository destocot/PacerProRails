require 'rails_helper'

RSpec.describe Item, type: :model do
  it "is valid with valid attributes" do
    item = Item.new(name: "Stapler")
    expect(item.name).to eq("Stapler")
    expect(item.deleted_at).to eq(nil)
  end

  it "is able to be soft deleted" do
    item = Item.new(name: "Stapler")
    item.soft_delete
    expect(item.deleted_at).not_to eq(nil)
    expect(item.deleted_at).to be_a(Time)
  end

  it "is able to be restored" do
    item = Item.new(name: "Stapler")
    item.soft_delete
    expect(item.deleted_at).not_to eq(nil)

    item.restore
    expect(item.deleted_at).to eq(nil)
  end 

  it "soft deleted items are excluded from normal queries" do
    item1 = Item.create(name: "Stapler")
    item2 = Item.create(name: "Pen")
    item3 = Item.create(name: "Paper")
    expect(Item.all.count).to eq(3)

    item2.soft_delete
    item3.soft_delete
    expect(Item.all.count).to eq(1)
  end 
end
