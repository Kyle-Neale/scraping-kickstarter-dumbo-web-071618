# require libraries/modules here
require "nokogiri"
require "pry"

def create_project_hash
  # write your code here
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  project_array = kickstarter.css("li.project.grid_4")

  projects = {}

  project_array.each do |project|
    # title: project.css("h2.bbcard_name strong a").text
    title = project.css("h2.bbcard_name strong a").text
    projects[title] = {
      # image_link: project.css("img.projectphoto-little").attribute("src").value
      :image_link => project.css("img.projectphoto-little").attribute("src").value,
      # description: project.css("p.bbcard_blurb").text
      :description => project.css("p.bbcard_blurb").text,
      # location : project.css("ul.project-meta").text
      :location => project.css("ul.project-meta").text,
      #funded: project.css("ul.project-stats li.first.funded strong").text --> .gsub("%", "").to_i
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
    }
    # binding.pry
  end
  projects
end

create_project_hash
