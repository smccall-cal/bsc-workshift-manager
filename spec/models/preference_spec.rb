RSpec.describe Preference, type: :model do
  it "is valid with valid attributes" do
      expect(Preference.new).to be_valid
  end

  it "have multiple shifts" do
    Preference.shifts
  end

  it "have days" do
    Preference.days
  end

  it "have times" do
    Preference.times
  end
end
