class Matcher

    attr_accessor :users, :shifts, :matches

    def initialize buildings
        @users = User.from(buildings).map { |user| [user.id, 5] }.to_h
        @shifts = ShiftTemplate.from(building).map { |shift| [[shift.name, shift.time], shift.hours] }.to_h
        @matches = Hash.new([])
    end

    def match
        while self.users.length > 0
            graph = generate_graph
            additional_matches = bipartite_matching graph
            update_lists_with additional_matches
        end
        return self.matches
    end

    def generate_graph
        null_users = -1.downto(self.users.length - self.shifts.length).to_a
        graph = { left: self.users.keys + null_users, right: self.shifts.keys, edges: Hash.new(Hash.new(1))}
        self.users.each{ |user, hours|
            graph[:edges][user] = Hash.new(0)
            self.shifts.each{ |shift, hours|
                name = shift[0]
                time = shift[1]
                graph[:edges][user][name] = preference user, name, time
            }
        }
        return graph
    end

    def preference user, shift, time
        stored = User.find(user).preference_for(shift, time)
        return - (stored)
    end


    def bipartite_matching graph
        return Graphmatch.match graph[:left], graph[:right], graph[:edges], :min_cost
    end

    def update_lists_with additional_matches
        additional_matches.delete_if { |user, shift| user == :source || user < 0 }
        self.matches = self.matches.merge(additional_matches) { |user, a, b| [a, b].flatten }
        additional_matches.each{ |user, shift|
            self.users[user] -= self.shifts[shift];
            self.shifts.delete shift }
        self.users.delete_if { |user, remaining| remaining == 0 }
    end

end
