class UrlOpener
  def initialize(datum)
    @datum = datum
  end

  # 画面に表示する文字
  def link_text
    @datum.content
  end

  # リンクの飛び先
  def target_path
    @datum.content
  end
end
