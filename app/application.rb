require "pry"

class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = ["Carrots", "Pears"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      elsif !@@cart.empty?
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
    elsif req.path.match(/add/)
      user_input = req.params["item"]
      resp.write add_items(user_input)
    else
      resp.write "Path Not Found"
    end
    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def add_items(input)
    if @@items.include?(input)
      @@cart << input
      return "added #{input}"
      #binding.pry
    else
      return "We don't have that item"
    end
  end
end
