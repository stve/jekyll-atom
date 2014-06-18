require 'spec_helper'

describe(Jekyll::JekyllAtom) do
  let(:config) do
    Jekyll.configuration({
      "source"      => source_dir,
      "destination" => dest_dir,
      "url"         => "http://example.org"
    })
  end
  let(:site)     { Jekyll::Site.new(config) }
  let(:contents) { File.read(dest_dir("feed.atom")) }
  before(:each) do
    site.process
  end

  it "creates a feed.atom file" do
    expect(File.exist?(dest_dir("feed.atom"))).to be true
  end

  it "sets the time the feed was updated" do
    expect(contents).to match /<updated>\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(-|\+)\d{2}:\d{2}<\/updated>/
  end

  it "puts all the posts in the feed" do
    expect(contents).to match /<link href="http:\/\/example.org\/2014\/03\/04\/march-the-fourth\.html"\/>/
    expect(contents).to match /<link href="http:\/\/example\.org\/2014\/03\/02\/march-the-second\.html"\/>/
    expect(contents).to match /<link href="http:\/\/example\.org\/2013\/12\/12\/dec-the-second\.html"\/>/
  end

  it "generates the correct date for each of the posts" do
    expect(contents).to match /<updated>2014-03-04T00:00:00-05:00<\/updated>/
    expect(contents).to match /<updated>2014-03-02T00:00:00-05:00<\/updated>/
    expect(contents).to match /<updated>2013-12-12T00:00:00-05:00<\/updated>/
  end
end
