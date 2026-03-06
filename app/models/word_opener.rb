class WordOpener < BaseOpener
  def link_text
    "Wordファイルを開く📄"
  end
  def target_path
    @datum.file
  end
  def icon
    "📝" # メモの絵文字
  end
end
