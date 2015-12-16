class ActivityFeed

  def self.message(activity)
   if activity.trackable_type == "Closet" && activity.action == "create" 
      "<em class = 'text-muted'>created closet</em> #{activity.trackable_name}" 

      elsif activity.trackable_type == "Closet" && activity.action == "destroy"
      "<em class = 'text-muted'>deleted closet</em> #{activity.trackable_name}" 


      elsif activity.trackable_type == "Item" && activity.action == "create"
      "<em class = 'text-muted'>added</em> #{activity.trackable_name} <em class = 'text-muted'>to</em> #{activity.trackable_source}" 
      
      elsif activity.trackable_type == "Item" && activity.action == "destroy"
      "<em class = 'text-muted'>deleted</em> #{activity.trackable_name} <em class = 'text-muted'>from</em> #{activity.trackable_source}"

      elsif activity.trackable_type == "User" && activity.action == "create"
      "<em class = 'text-muted'>followed</em> #{activity.trackable.username}" 
  
      elsif activity.trackable_type == "User" && activity.action == "destroy"
      "<em class = 'text-muted'>unfollowed</em> #{activity.trackable.username}"
      
  end
end

end