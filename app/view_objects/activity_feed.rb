class ActivityFeed

  def self.actionmessage(activity)
    if activity.trackable_type == "Closet" && activity.action == "create"
      "created closet"

      elsif activity.trackable_type == "Closet" && activity.action == "destroy"
      "deleted closet" 

      elsif activity.trackable_type == "Item" && activity.action == "create"
      "added" 
      
      elsif activity.trackable_type == "Item" && activity.action == "destroy"
      "deleted"

      elsif activity.trackable_type == "User" && activity.action == "create"
      "followed" 
  
      elsif activity.trackable_type == "User" && activity.action == "destroy"
      "unfollowed" 
    end
  end

  def self.subject(activity)
    activity.trackable_name
  end

  def self.preposition(activity)
    if activity.action == "create"
      "to"
    else
      "from"
    end
  end

  def self.closet(activity)
    activity.trackable_source
  end

end

