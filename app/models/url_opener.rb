class UrlOpener < BaseOpener
  def link_text
    @datum.content
  end
  def target_path
    @datum.content
  end
  def icon
    "🌐" # 地球儀の絵文字
  end
end
