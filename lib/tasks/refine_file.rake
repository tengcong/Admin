namespace :file do
  task refine: :environment do

    base = "http://www.qqtn.com"

    Bq.all.each do |bq|
      if !bq.origin_url[/http/]
        url = "#{base}#{bq.origin_url}"
        bq.update origin_url: url
      end
    end
  end

  task orderable: :environment do
    BqPackage.desc.each do |package|
      package.save
    end
  end
end
