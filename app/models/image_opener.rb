class ImageOpener < BaseOpener
  def initialize(datum)
    @datum = datum
  end
  def link_text
    "画像を開く📷"
  end
  def target_path
    @datum.file
  end
  def icon
    "🖼️" # フレームの絵文字
  end
end
