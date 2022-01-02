module ApplicationHelper

  def is_feature_checked?(id)
    params.fetch(:instrument, {}).fetch(:feature_ids, []).include?(id.to_s)
  end

  def all_booked?(disponibilities,bookings)
    disponibilities.pluck(:id).sort == bookings.pluck(:disponibility_id).sort
  end

  def show_svg(path)
    File.open("app/assets/images/svg/#{path}", "rb") do |file|
      raw file.read
    end
  end
end
