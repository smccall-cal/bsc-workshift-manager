RSpec.describe Preference, type: :model do

  it "is valid with valid attributes" do
      # Preference.new valid_attributes
      # expect(Preference.save).to be_truthy
  end

  it "have multiple shifts" do
    expect(Preference.shifts.length).to be > 1
  end

  it "have multiple days" do
      expect(Preference.days.length).to be > 1
  end

  it "have multiple times" do
      expect(Preference.shifts.length).to be > 1
  end
end
