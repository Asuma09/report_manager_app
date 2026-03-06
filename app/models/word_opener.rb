class WordOpener
  def initialize(datum)
    @datum = datum
  end

  def link_text
    "Wordファイルを開く📄"
  end

  def target_path
    @datum.file
  end
end
