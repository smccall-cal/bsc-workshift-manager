require 'spec_helper'
require 'rails_helper'

RSpec.describe Matcher do

    before(:each) do
        allow(User).to receive(:where).and_return([])
        allow(ShiftTemplate).to receive(:where).and_return([])
        @matcher = Matcher.new "CZ"

        @matcher.users = (1..5).map { |i| [i, 5] }.to_h
        @matcher.shifts = ("A".."J").map { |i| [i, 2.5] }.to_h

        @user = double("user")
        allow(User).to receive(:find).and_return(@user)
    end

    it "finds the user's preference, if it exists" do
        allow(@user).to receive(:preference_for).and_return(5)
        expect(@matcher.preference 1, 0).to eq(-5)
    end

    it "gives a valid user a default preference of 0" do
        allow(@user).to receive(:preference_for).and_return(0)
        expect(@matcher.preference 1, 0).to eq(0)
    end

    it "generates the proper number of null_users" do
        allow(@matcher).to receive(:preference).and_return(0)
        expect(@matcher.generate_graph[:left].length).to eq 10
    end

    it "removes users with no hours with each iteration" do
        @matcher.users[6] = 0
        expect(@matcher.users.keys).to eq (1..6).to_a
        @matcher.update_lists_with Hash.new
        expect(@matcher.users.keys).to eq (1..5).to_a
    end

    it "removes assigned shifts with each iteration" do
        additional = {1 => "A", 2 => "B"}
        @matcher.update_lists_with additional
        expect(@matcher.shifts.keys).to eq ("C".."J").to_a
    end

    it "decrements users' hours with each iteration" do
        additional = {1 => "A", 2 => "B"}
        @matcher.update_lists_with additional
        expect(@matcher.users[1]).to eq 2.5
    end

    it "only updates based on real matchings" do
        additional = {1 => "A", 2 => "B", -1 => "C", -2 => "D"}
        @matcher.update_lists_with additional
        expect(@matcher.shifts.keys).to eq ("C".."J").to_a
    end

    it "runs" do
        allow(@user).to receive(:preference_for).and_return(5)
        @matcher.match
    end

    it "runs until all users are assigned shifts" do
        allow(@user).to receive(:preference_for).and_return(5)
        @matcher.match
        expect(@matcher.users.length).to eq(0)
    end

    it "assigns all shifts when possible" do
        allow(@user).to receive(:preference_for).and_return(5)
        expect(@matcher.match.flatten(5).length).to eq(15)
    end

    it "terminates if all shifts aren't assigned, if all users have shifts" do
        allow(@user).to receive(:preference_for).and_return(5)
        @matcher.shifts["K"] = 2.5
        @matcher.match
        expect(@matcher.users.length).to eq(0)
        expect(@matcher.shifts.length).to eq(1)
    end
end
