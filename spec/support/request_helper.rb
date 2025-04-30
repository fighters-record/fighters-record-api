module RequestHelper
  def get_with_host(path, headers: {}, **args)
    get path, **args.merge(headers: headers.merge({ 'HOST' => 'localhost' }))
  end

  def post_with_host(path, params: {}, headers: {}, **args)
    post path, params: params, **args.merge(headers: headers.merge({ 'HOST' => 'localhost' }))
  end

  def put_with_host(path, params: {}, headers: {}, **args)
    put path, params: params, **args.merge(headers: headers.merge({ 'HOST' => 'localhost' }))
  end

  def delete_with_host(path, headers: {}, **args)
    delete path, **args.merge(headers: headers.merge({ 'HOST' => 'localhost' }))
  end
end