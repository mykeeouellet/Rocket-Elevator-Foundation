class Streamer
    require 'net/http'
    require 'json'

   def self.getContent
        url = URI.parse('https://api.nasa.gov/planetary/apod?api_key=zOo3dMwTVU2F039jljNCfbowWVnMjRvYAqEIWBv8')
        res = Net::HTTP.get_response(url)
        @body = JSON.parse(res.body)
        @date = @body['date']
        @title = @body['title']
        @hdurl = @body['hdurl']
        @explanation = @body['explanation']
        @copyright = @body['copyright']
        @html = "<div><h1>Nasa Picture Of The Day</h1>Date: #{@date}<br>Title: #{@title}<br>Image: #{@hdurl}<br>Explanation: #{@explanation}<br>Copyright: #{@copyright}</div>"
        puts "===================== The Image ========================"
        puts "Date: #{@date}"
        puts "Title: #{@title}"
        puts "Url: #{@hdurl}"
        puts "========================================================"
        return @html
    end

end

 