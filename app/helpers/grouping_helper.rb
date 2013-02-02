module GroupingHelper
def week
  self.created_at.strftime("%W")
end

def month
  self.created_at.strftime("%y%m")
end
end
