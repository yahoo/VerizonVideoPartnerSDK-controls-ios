###Pushing diff images into comments
require 'json'
require 'active_support/core_ext/string/output_safety'

warn 'Big PR - break it to smaller PRs.' if git.lines_of_code > 500

warn 'This PR does not have any assignees yet.' unless github.pr_json['assignee']

warn 'PR is marked as Work In Progress.' if github.pr_title.include? "WIP"

build_type = ENV['TRAVIS_EVENT_TYPE']
if build_type.eql? "pull_request"
	branch_name = ENV['TRAVIS_PULL_REQUEST_BRANCH']
	fail 'Please, attach JIRA ticket link to the branch name' unless branch_name[/OMSDK-[0-9]{3,}\/.{3,}/]
end

warn 'Please, set correct Jira link in the PR comment.' if 
github.pr_body.include? "[JIRA Ticket](xxx)"

if File.exist?('keys.json')
    file = File.read('keys.json')
    data = JSON.parse(file)
end

if !data.nil?
    #Dropping all images exept diffs from current branch
    newData = []
    data.each do |key|
        if key.include? "diff"
            newData.push(key)
        end
    end
    if newData.count != 0
        words = newData.count > 1 ? "snapshots were" : "snapshot was"
        print "#{newData.count} #{words} found. \n"
    
        #Getting and array of urls for these images
        urlArray = []
        newData.each do |key|
            url = "https://aol-public.s3.amazonaws.com/#{key}"
            urlArray.push(url)
        end
        
        #Reverse sort for array to make iPhones go first
        urlArray = urlArray.sort.reverse
        
        #Getting unique names of testcases
        testcases = newData.map do |key|
            key.sub("Failures/#{github.branch_for_head}/", "")
        end
        testcases.map do |key|
            index = key.index("/")
            key.slice! index..key.length
        end
        testcases = testcases.uniq
    
        #Getting an array of html
        mdArray = urlArray.map do |url_markdown|
            url_markdown = "![image](#{url_markdown})"
        end
    
        #Creating a Danger failure for each testcase with an array of images
        for test in testcases do
            imagesStr_md = ""
            firstImage = ""
            mdArray.each do |image|
                if image.include? test
                    imagesStr_md += image + "\n"
                    if firstImage == ""
                        firstImage = image
                    end
                end
            end
            output = "### #{test}\n #{firstImage} \n <details> \n\n #{imagesStr_md} \n </details> <br>"
            fail(output.html_safe)
        end
    else
        print "\nNo diff images found. \n"
    end
end
