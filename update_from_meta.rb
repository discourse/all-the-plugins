require 'json'
require 'open-uri'

$existing_modules = File.read('plugins.txt')
                        .split("\n")
                        .filter{ |str| str.size > 0 }
                        .compact

def ensure_repo(title, topic_url)
  return if title =~ /about the plugin category/i

  result = open(topic_url).read
  json = JSON.parse(result)

  op_body = json["post_stream"]["posts"][0]["cooked"]

  first_github = nil
  op_body.scan(/href=['"](http[^'"]+github[^'"]+)/i) do
    first_github = $1
    unless first_github =~ /issuecomment/
      break
    end
  end

  if first_github
    if $existing_modules.any?{|m| first_github.include?(m)}
      return
    end
  end

  if first_github
    puts "Add #{title}: #{path} (Y/n)"
    text = readline
    unless text =~ /n/
      File.write("plugins.txt", "#{path}\n", mode: 'a+')
      puts "Added #{path}"
    end
  end

end

url = 'https://meta.discourse.org/c/plugin/none.json'
begin
  result = open(url).read
  json = JSON.parse(result)

  topic_list = json["topic_list"]
  topics = topic_list["topics"]

  topics.each do |topic|
    topic_url = "https://meta.discourse.org/t/#{topic["slug"]}/#{topic["id"]}.json"
    ensure_repo(topic["title"], topic_url)
  end

  break unless topic_list["more_topics_url"]

  url = "https://meta.discourse.org#{topic_list["more_topics_url"]}"
  url = url.sub("latest", "latest.json")
end while topics.length > 0
