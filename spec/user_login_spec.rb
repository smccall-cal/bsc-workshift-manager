require 'spec_helper'
require 'User'
require 'digest'

describe User do

    before(:each) do
        a = "Username of some sort"
        b = "Password of some sort"
        h = Digest::SHA256.digest b
    end

    it "accepts a username and password" do
        expect(User).to receive(:create)
        User.init(a, b)
    end

    it "correctly hides the password" do
        expect(User).to receive(:create).with(a, h)
        User.init(a, b)
    end

    describe LoggingOn do

        before(:each) do
            User.create(a, h)
        end

        it "validates in a valid user" do
            expect(User.validate(a, b)).to eq(true)
        end

        it "invalidates in an invalid user" do
            expect(User.validate(a, "rubyistheworst")).to eq(false)
        end

    end

end
