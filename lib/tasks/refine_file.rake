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

  task change_tag_name: :environment do

    mapping = {
      weixin: '微信',
      gaoxiao: '搞笑',
      sh: '手绘',
      dt: '动态',
      tieba: '贴吧',
      dm: '动漫',
      liaotian: '聊天',
      keai: '可爱',
      weisuo: '猥琐',
      wenzi: '文字',
      maim: '卖萌',
      koubi: '抠鼻',
      tux: '吐血',
      tuzi: '兔子',
      gguai: '搞怪',
      shengq: '生气',
      jingdian: '经典',
      yuanc: '原创',
      jieri: '节日',
      zhufu: '祝福'
    }

    BqType.all.each do |type|
      type.update(name: mapping[type.name.to_sym]) if mapping[type.name.to_sym]
    end
  end

  task add_tags: :environment do
    BqPackage.each do |package|
      package.tags = [package.bq_type.try(:name)]
      package.save
    end
  end
end
