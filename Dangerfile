require 'json'

file = File.read('keys.json')

data = JSON.parse(file)

# Making URL from array of keys
urlArray = []
data.each do |key|
    if key.include? "diff"
        urlArray.push("https://aol-public.s3.amazonaws.com/#{key}")
    end
end

print urlArray

htmlArray = urlArray.map do |url|
    url = "<img src=#{url}>"
end

print htmlArray

if urlArray.count != 0
    testcases = data.map do |key|
    (key.reverse.chomp! "Failures/s3-AmazonDiffs/".reverse).reverse
    end
    testcases.map do |key|
        index = key.index("/")
        key.slice! index..key.length
    end
    testcases = testcases.uniq
    print testcases
    for test in testcases do
        print "\n \n"
        imagesSrc = []
        htmlArray.each do |image|
            if image.include? test
                imagesSrc.push(image)
            end
        end
        imagesSrc = imagesSrc.join(" ")
        fail("#{test}\n #{imagesSrc}")
    end
end






# Warn when there is a big PR
warn("Big PR") if git.lines_of_code > 500
warn("Small PR") if git.lines_of_code < 15


#if git.modified_files.include? "SnapshotTests/Tests/ReferenceImages/*.jpg"
#  config_files = git.modified_files.select { |path| path.include? "SnapshotTests/Tests/ReferenceImages/" }
#  warn("This PR has ovveriden reference images #{ github.html_link(config_files) }")
#end

#if git.modified_files.include? "Demo/Tests/DiffImages/*.jpg"
#  config_files = git.modified_files.select { |path| path.include? "Demo/Tests/" }
#  fail "Tests are failed. Here're difference images  #{ github.html_link(config_files)}"
#end

#message "This PR changes #{ github.html_link(config_files)

#junit.parse "fastlane/test_output/report.junit"
#junit.headers = %i(file name)
#junit.report

#Instead junit.report - fail("Tests failed") unless junit.failures.empty?
