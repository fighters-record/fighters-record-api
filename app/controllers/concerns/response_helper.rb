# レスポンスヘルパー
module ResponseHelper
  def render_success(resource = nil, status: :ok)
    render json: {
      status: 'success',
      data: serialize_resource(resource),
      errors: nil
    }, status: status
  end

  def render_error(messages, status: :bad_request)
    render json: {
      status: 'error',
      data: nil,
      errors: Array(messages)
    }, status: status
  end

  private

  # AMS互換を見越して切り出し
  def serialize_resource(resource)
    return nil if resource.nil?

    if resource.respond_to?(:as_json)
      resource.as_json
    else
      resource
    end
  end
end
