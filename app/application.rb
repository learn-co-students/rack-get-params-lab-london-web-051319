class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/cart/)

      if @@cart.length > 0
        @@cart.each do |item|
        resp.write "#{item}\n"
        end
      else
        resp.write "Your cart is empty"
      end

    elsif req.path.match(/add/)
      search_term = req.params["item"]

      if @@items.include?(search_term)
        @@cart << search_term
        resp.write "added #{search_term}"
      else
        resp.write "We don't have that item"
      end

    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

end
