module ApplicationHelper
  
  def is_feature_checked?(id)
    params.fetch(:instrument, {}).fetch(:feature_ids, []).include?(id.to_s)
  end
end
