require "json"
require "open-uri"

$existing_plugins =
  File.read("third-party.txt").split("\n").compact + File.read("official.txt").split("\n").compact
$list = []

def ensure_repo(title, topic_url)
  return if title =~ /about the plugin category/i

  result = URI.open(topic_url).read
  json = JSON.parse(result)

  op_body = json["post_stream"]["posts"][0]["cooked"]

  match = op_body.scan(%r{https://github\.com/[A-Z0-9_\-]+/[A-Z0-9_\-]+}i)
  github_url = match && match[-1]

  return if !github_url
  return if $existing_plugins.any? { |m| github_url.include?(m) }

  repo = github_url.sub("https://github.com/", "")

  puts title
  puts topic_url.sub(".json", "")
  puts github_url
  print "Add? (Y/n) "
  text = readline

  $list << repo unless text =~ /n/

  puts "\n"
end

url = "https://meta.discourse.org/c/plugin/none.json"

begin
  result = URI.open(url).read
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

puts $list
