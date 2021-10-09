module ApplicationHelper

  def is_feature_checked?(id)
    params.fetch(:instrument, {}).fetch(:feature_ids, []).include?(id.to_s)
  end

  def all_booked?(disponibilities,bookings)
    disponibilities.pluck(:id).sort == bookings.pluck(:disponibility_id).sort
  end
end
