class Pengpeng

  PENG_TYPE = [
    "ad@@admob",
    "add@@20"
    # "video@@http://www.xxx.com/aaa.mp4",
    # "web@@http://baidu.com"
  ]

  class << self
    def get_result
      i = (0...PENG_TYPE.size).to_a.sample
      PENG_TYPE[i]
    end
  end

end
