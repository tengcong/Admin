class Pengpeng

  PENG_TYPE = [
    "ad@@admob",
    "add@@20",
    "web@@http://baidu.com",
    "video@@http://lol-video.b0.upaiyun.com/mm.mp4",
    "video@@http://lol-video.b0.upaiyun.com/test.mp4"
  ]

  class << self
    def get_result
      i = (0...PENG_TYPE.size).to_a.sample
      PENG_TYPE[i]
    end
  end

end
