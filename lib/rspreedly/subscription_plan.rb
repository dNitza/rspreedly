module RSpreedly
    
  class SubscriptionPlan < Base
    
    attr_accessor :amount,
                  :charge_after_first_period,
                  :charge_later_duration_quantity,
                  :charge_later_duration_units,
                  :created_at,
                  :currency_code,
                  :description,
                  :duration_quantity,
                  :duration_units,
                  :enabled,
                  :feature_level,
                  :force_recurring,
                  :id,
                  :name,
                  :needs_to_be_renewed,
                  :plan_type,
                  :price,
                  :return_url,
                  :terms,
                  :updated_at
    
    # there's no API method for just getting one plan, so we fake it!
    def self.find(id)
      return all if id == :all
      all.find{|plan| plan.id == id.to_i}
    end

    def self.find_by_feature_level(feature_level)
      return all if feature_level == :all
      all.find{|plan| plan.feature_level == feature_level.to_s}
    end    
    
    # Get a list of all subscription plans (more)
    # GET /api/v4/[short site name]/subscription_plans.xml
    def self.all
      response = api_request(:get, "/subscription_plans.xml")
      return [] unless response.has_key?("subscription_plans")
      response["subscription_plans"].collect{|data| SubscriptionPlan.new(data)}
    end
    
    # Get a list of all active subscription plans (more)
    # GET /api/v4/[short site name]/subscription_plans.xml
    def self.active
      all.reject { |plan| !plan.enabled }
    end
    
  end
end
